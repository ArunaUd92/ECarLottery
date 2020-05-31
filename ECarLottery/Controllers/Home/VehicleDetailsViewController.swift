//
//  VehicleDetailsViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 4/26/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

struct Specifications {
    var title: String = ""
    var description: String = ""
}

protocol AddCartActionDelegate {
    func addToCartItem(indexPath: IndexPath)
}
class VehicleDetailsViewController: ImageZoomAnimationVC {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var closeButton : UIButton!
    @IBOutlet weak var lblCorrectAnswer : UILabel!
    @IBOutlet weak var lblVehicleDetailsName: UILabel!
    @IBOutlet weak var lblTicketPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblMaxTicketSoldCount: UILabel!
    @IBOutlet weak var lblMinTicketSoldCount: UILabel!
    @IBOutlet weak var lblRemainingTicketCount: UILabel!
    @IBOutlet weak var txtTicketCount: UITextField!
    @IBOutlet weak var linearProgressView: LinearProgressView!
    @IBOutlet weak var specificationsDataTableView: UITableView!
    @IBOutlet weak var specificationsTableViewHeight: NSLayoutConstraint!
    
    var addCartActionDelegate: AddCartActionDelegate!
    
    var selectedItemIndexpath = IndexPath()
    var specificationsDataList: [Specifications] = []
    var eCarLotteryObject: ECarLottery? = nil
    
    let ticketCountPicker: UIPickerView = UIPickerView()
    var ticketCountArray: [String] = []
    
    deinit {
        print("deinit ModalViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setupSpecificationsData()
        
        ticketCountPicker.delegate = self
        ticketCountPicker.dataSource = self
        txtTicketCount?.inputView = ticketCountPicker
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ModalViewController viewWillAppear")
        
        //        view.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
        //        UIView.animate(withDuration: 0.5, animations: { [weak self] in
        //            self?.view.transform = CGAffineTransform.identity
        //        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ModalViewController viewWillDisappear")
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.specificationsTableViewHeight.constant = self.specificationsDataTableView.contentSize.height + 20
        self.specificationsDataTableView.layoutIfNeeded()
    }
    
    private func setUpData(){
        for count in 0 ... 24{
            let number = count + 1
            ticketCountArray.append(number.toString())
        }
    }
    
    // MARK: - ImageTransitionZoomable
    override func createTransitionImageView() -> UIImageView {
        let imageView = UIImageView(image: self.imageView.image)
        imageView.contentMode = self.imageView.contentMode
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.frame = self.imageView!.frame
        return imageView
    }

    override func presentationBeforeAction() {
        self.imageView.isHidden = true
    }

    override func presentationCompletionAction(didComplete: Bool) {
        self.imageView.isHidden = false
    }

    override func dismissalBeforeAction() {
        self.imageView.isHidden = true
    }

    override func dismissalCompletionAction(didComplete: Bool) {
        if !didComplete {
            self.imageView.isHidden = false
        }
    }
    
    func setupSpecificationsData(){
        
        self.lblDescription.text = eCarLotteryObject?.description
        self.lblVehicleDetailsName.text = eCarLotteryObject?.name
        self.lblTicketPrice.text = "£\(eCarLotteryObject?.price ?? "")"
        
        self.linearProgressView.maximumValue = Float((eCarLotteryObject?.tickets_count)!)
        self.linearProgressView.minimumValue = 0.0
        self.linearProgressView.setProgress(Float((eCarLotteryObject?.tickets_sold)!), animated: true)
        
        self.lblRemainingTicketCount.text  = "Only \((eCarLotteryObject?.tickets_count)! - (eCarLotteryObject?.tickets_sold)!) remaining!"
        
        self.lblMaxTicketSoldCount.text = eCarLotteryObject?.tickets_count?.toString()
        self.lblMaxTicketSoldCount.text = eCarLotteryObject?.tickets_count?.toString()
        
        if let vehicleImageURL = try? eCarLotteryObject?.images![0].images![0].images!.asURL() {
            imageView.kf.setImage(with: vehicleImageURL)
        }
        
        // set table data
        specificationsDataList.append(Specifications.init(title: "MAKE / MODEL:", description: "\(eCarLotteryObject?.features?.make ?? "") \(eCarLotteryObject?.features?.model ?? "")"))
        specificationsDataList.append(Specifications.init(title: "MAKE YEAR:", description: eCarLotteryObject?.features?.year ?? ""))
        specificationsDataList.append(Specifications.init(title: "MILLAGE:", description: eCarLotteryObject?.features?.millage ?? ""))
        specificationsDataList.append(Specifications.init(title: "VEHICLE TYPE:", description: eCarLotteryObject?.features?.type ?? ""))
        specificationsDataList.append(Specifications.init(title: "ENGINE TYPE:", description: eCarLotteryObject?.features?.engine_type ?? ""))
        specificationsDataList.append(Specifications.init(title: "TRANSMISSION:", description: eCarLotteryObject?.features?.transmission ?? ""))
        specificationsDataList.append(Specifications.init(title: "DOORS:", description: eCarLotteryObject?.features?.doors ?? ""))
        
        specificationsDataTableView.reloadData()
    }
    
    // MARK: Button event action
    @IBAction func btnBackAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnBuyAction(_ sender: Any) {
         addCartActionDelegate.addToCartItem(indexPath: self.selectedItemIndexpath)
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func answerPopUpViewAction(_ sender: Any) {
        
        if let answerList = eCarLotteryObject?.questions![0].answer, !answerList.isEmpty {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let answerPopUpViewController = storyboard.instantiateViewController(withIdentifier: "AnswerPopUpViewController") as! AnswerPopUpViewController
            answerPopUpViewController.answerList = answerList
            answerPopUpViewController.correctAnswerDelegate = self
            answerPopUpViewController.modalTransitionStyle = .crossDissolve
            answerPopUpViewController.modalPresentationStyle = .overFullScreen
            self.present(answerPopUpViewController, animated: true, completion: nil)
        }
    }
}

// MARK: - Table View DataSource
extension VehicleDetailsViewController: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecificationsTableViewCell", for: indexPath) as! SpecificationsTableViewCell
        let specificationItem = specificationsDataList[indexPath.row]
        cell.lblTitle.text = specificationItem.title
        cell.lblDescription.text = specificationItem.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.specificationsDataList.count
    }
    
}

// MARK: - Table View Delegate
extension VehicleDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}

extension VehicleDetailsViewController: CorrectAnswerDelegate {
    
    func setCorrectAnswerAction(answerObject: Answer) {
        self.lblCorrectAnswer.text = answerObject.answer
    }
}

extension VehicleDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - UIPickerView delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == ticketCountPicker) {
            return ticketCountArray.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == ticketCountPicker) {
            return ticketCountArray[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == ticketCountPicker) {
            let ticketCount: String = ticketCountArray[row] ?? ""
            txtTicketCount?.text = ticketCount
        }
    }
}




