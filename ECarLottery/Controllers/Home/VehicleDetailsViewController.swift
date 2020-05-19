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
    
    @IBOutlet weak var specificationsDataTableView: UITableView!
    @IBOutlet weak var specificationsTableViewHeight: NSLayoutConstraint!
    
    var addCartActionDelegate: AddCartActionDelegate!
    
    var selectedItemIndexpath = IndexPath()
    var specificationsDataList: [Specifications] = []
    
    deinit {
        print("deinit ModalViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpecificationsData()
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
        
        specificationsDataList.append(Specifications.init(title: "Make / model:", description: "Mercedes Benz C63 6.2 AMG COUPE"))
        specificationsDataList.append(Specifications.init(title: "Make year:", description: "2013"))
        specificationsDataList.append(Specifications.init(title: "Millage:", description: "74000"))
        specificationsDataList.append(Specifications.init(title: "Baths", description: "2"))
        specificationsDataList.append(Specifications.init(title: "vehicle type:", description: "Sport"))
        specificationsDataList.append(Specifications.init(title: "ENGINE TYPE:", description: "6.2"))
        specificationsDataList.append(Specifications.init(title: "Doors:", description: "2"))
        
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



