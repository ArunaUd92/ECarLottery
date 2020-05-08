//
//  HomeViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 4/26/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit
import ARNTransitionAnimator

class HomeViewController: ImageZoomAnimationVC {

    @IBOutlet weak var homeTableView: UITableView!
    
    weak var selectedImageView : UIImageView?
    var animator : ARNTransitionAnimator?
    var isModeInteractive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extendedLayoutIncludesOpaqueBars = false
        
        homeTableView.estimatedRowHeight = 506.0
        homeTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MainViewController viewWillAppear")
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
        
        controller.transitioningDelegate = animator
        self.animator = animator
        
        self.present(controller, animated: true, completion: nil)
    }

    // MARK: Button event action
    @IBAction func btnShoppingCartAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        cartVC.modalPresentationStyle = .overFullScreen
        self.present(cartVC, animated: false, completion: nil)
    }
    
}

// MARK: - Table View DataSource
extension HomeViewController: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}

// MARK: - Table View Delegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
        self.selectedImageView = cell.vehicleImageView1
        
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
