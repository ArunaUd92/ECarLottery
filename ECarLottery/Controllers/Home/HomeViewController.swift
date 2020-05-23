//
//  HomeViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 4/26/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit
import ARNTransitionAnimator
import NVActivityIndicatorView
import Alamofire
import Kingfisher

class HomeViewController: ImageZoomAnimationVC, CAAnimationDelegate {
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var lableNoOfCartItem: UILabel!
    
    weak var selectedImageView : UIImageView?
    var animator : ARNTransitionAnimator?
    var isModeInteractive : Bool = false
    var selectedIndexpath = IndexPath()
    
    var counterItem = 0
    var eCarLotteryList: [ECarLottery] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarWithTitle(navigationTitle: "Home")
        
        lableNoOfCartItem.layer.cornerRadius = lableNoOfCartItem.frame.size.height / 2
        lableNoOfCartItem.clipsToBounds = true
        
//        if let revealController = self.revealViewController() {
//            revealController.tapGestureRecognizer()
//            btnMenuButton.target = revealController
//            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
//        }
        
//        let shoppingCartBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "shopping_cart"), style: .done, target: self, action: #selector(btnShoppingCartAction(_ :)))
//        self.navigationItem.rightBarButtonItems = [shoppingCartBarButton]
        
        self.extendedLayoutIncludesOpaqueBars = false
        
        homeTableView.estimatedRowHeight = 506.0
        homeTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MainViewController viewWillAppear")
      //  getECarLotteryList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("MainViewController viewWillDisappear")
    }
    
    override func createTransitionImageView() -> UIImageView {
        let imageView = UIImageView(image: self.selectedImageView!.image)
        imageView.contentMode = self.selectedImageView!.contentMode
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.frame = self.selectedImageView!.convert(self.selectedImageView!.frame, to: self.view)
        
        return imageView
    }
    
    @objc override func presentationBeforeAction() {
        self.selectedImageView?.isHidden = true
    }
    
    override func presentationCompletionAction(didComplete: Bool) {
        self.selectedImageView?.isHidden = true
    }
    
    @objc override func dismissalBeforeAction() {
        self.selectedImageView?.isHidden = true
    }
    
    override func dismissalCompletionAction(didComplete: Bool) {
        self.selectedImageView?.isHidden = false
    }
    
    func getECarLotteryList() {
        
        if !(NetworkReachabilityManager()?.isReachable)! {
            self.popupAlert(title: "Network error", message: "NO INTERNET", actionTitles: ["RETRY", "CANCEL"], actions: [{ action1 in
                self.getECarLotteryList()
                }, { action2 in
                    
                }, nil])

        } else {
            
            let homeService = HomeService()
            
            self.showProgress()
            homeService.getECarLotteryList(onSuccess: { (response: [ECarLottery]) -> Void in
                self.hideProgress()
                
                self.eCarLotteryList += response
                self.homeTableView.reloadData()
                
            }, onResponseError: { (error: String, code: Bool) -> Void in
                print(error)
                self.hideProgress()
                ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: error)
                
            }, onError: { (error: String, code: Int) -> Void in
                print(error)
                self.hideProgress()
                ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: error)
            })
        }
    }
    
    func handleTransition() {
        if isModeInteractive {
            self.showInteractive()
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "VehicleDetailsViewController") as! VehicleDetailsViewController
            controller.modalPresentationStyle = .fullScreen
            let animation = ImageZoomAnimation<ImageZoomAnimationVC>(rootVC: self, modalVC: controller, rootNavigation: self.navigationController)
            let animator = ARNTransitionAnimator(duration: 0.5, animation: animation)
            controller.transitioningDelegate = animator
            self.animator = animator
            controller.addCartActionDelegate = self
            controller.selectedItemIndexpath = self.selectedIndexpath
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func showInteractive() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "VehicleDetailsViewController") as! VehicleDetailsViewController
        
        let animation = ImageZoomAnimation<ImageZoomAnimationVC>(rootVC: self, modalVC: controller, rootNavigation: self.navigationController)
        let animator = ARNTransitionAnimator(duration: 0.5, animation: animation)
        
        let gestureHandler = TransitionGestureHandler(targetView: controller.view, direction: .bottom)
        animator.registerInteractiveTransitioning(.dismiss, gestureHandler: gestureHandler)
        
        controller.addCartActionDelegate = self
        controller.selectedItemIndexpath = self.selectedIndexpath
        controller.transitioningDelegate = animator
        self.animator = animator
        
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: Button event action
    @IBAction func btnShoppingCartAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: "YourCartViewController") as! YourCartViewController
        cartVC.modalPresentationStyle = .overFullScreen
        self.present(cartVC, animated: false, completion: nil)
    }
    
    @IBAction func btnSlideMenuAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let askCommunityVC = storyboard.instantiateViewController(withIdentifier: "LeftSlideMenuViewController") as! LeftSlideMenuViewController
        askCommunityVC.modalPresentationStyle = .overFullScreen
        self.present(askCommunityVC, animated: false, completion: nil)
    }
    
    @IBAction func btnFilterAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let filterViewController = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        filterViewController.modalTransitionStyle = .crossDissolve
        filterViewController.modalPresentationStyle = .overFullScreen
        self.present(filterViewController, animated: true, completion: nil)
    }
    
//    @objc func btnShoppingCartAction(_ sender: UIBarButtonItem) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let cartVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
//        cartVC.modalPresentationStyle = .overFullScreen
//        self.present(cartVC, animated: false, completion: nil)
//    }
    
}

// MARK: - Table View DataSource
extension HomeViewController: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
//        let eCarLottery = self.eCarLotteryList[indexPath.row]
//        cell.lblVehicleName.text = eCarLottery.name
//        cell.lblVehicleYear.text = eCarLottery.features?.year
//        cell.lblVehiclePrice.text = "$ \(eCarLottery.price ?? "")"
//        cell.lblVehicleMileage.text = eCarLottery.features?.millage
//
//        if let vehicleImageURL = try? eCarLottery.images?.image1!.asURL() {
//            cell.vehicleImageView.kf.setImage(with: vehicleImageURL)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return self.eCarLotteryList.count
        return 5
    }
    
}

// MARK: - Table View Delegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
        self.selectedImageView = cell.vehicleImageView
        self.selectedIndexpath = indexPath
        
        self.handleTransition()
        
        //        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
        //            // HERE
        //            let cell = self.homeTableView.cellForRow(at: indexPath) as! HomeTableViewCell
        //            cell.vehicleImageView1.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)// Scale your image
        //            cell.mainBackgroundView.transform = CGAffineTransform.identity.scaledBy(x: 1.4, y: 1.4)
        //
        //        }) { (finished) in
        //            UIView.animate(withDuration: 1, animations: {
        //                let cell = self.homeTableView.cellForRow(at: indexPath) as! HomeTableViewCell
        //                cell.vehicleImageView1.transform = CGAffineTransform.identity // undo in 1 seconds
        //                 cell.mainBackgroundView.transform = CGAffineTransform.identity
        //                let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                let vehicleDetailsVC = storyboard.instantiateViewController(withIdentifier: "VehicleDetailsViewController") as! VehicleDetailsViewController
        //                vehicleDetailsVC.modalPresentationStyle = .overFullScreen
        //                self.present(vehicleDetailsVC, animated: false, completion: nil)
        //            })
        //        }
        
    }
}

extension HomeViewController: AddCartActionDelegate {
    
    func addToCartItem(indexPath: IndexPath) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            
            let cell = self.homeTableView.cellForRow(at: indexPath) as! HomeTableViewCell
            
            let imageViewPosition : CGPoint = cell.vehicleImageView.convert(cell.vehicleImageView.bounds.origin, to: self.view)
            
            let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.vehicleImageView.frame.size.width, height: cell.vehicleImageView.frame.size.height))
            
            imgViewTemp.image = cell.vehicleImageView.image
            
            self.animation(tempView: imgViewTemp)
        }
    }
    
    func animation(tempView : UIView)  {
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 1.0,
                       animations: {
                        tempView.animationZoom(scaleX: 1.0, y: 1.0)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
                tempView.animationRoted(angle: CGFloat(Double.pi))
                
                tempView.frame.origin.x = self.btnCart.frame.origin.x
                tempView.frame.origin.y = self.btnCart.frame.origin.y
                
            }, completion: { _ in
                
                tempView.removeFromSuperview()
                
                UIView.animate(withDuration: 1.0, animations: {
                    
                    self.counterItem += 1
                    self.lableNoOfCartItem.text = "\(self.counterItem)"
                    self.btnCart.animationZoom(scaleX: 1.4, y: 1.4)
                }, completion: {_ in
                    self.btnCart.animationZoom(scaleX: 1.0, y: 1.0)
                })
                
            })
            
        })
    }
}

extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
}

