//
//  CartViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 4/30/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit
import ARNTransitionAnimator

private let kReuseCellID = "reuseCellID"
private let kImgName = "img_"
private let kTotalImgs = 10

class CartViewController: ImageZoomAnimationVC {

    @IBOutlet weak var vehicleCollectionView: UICollectionView!
    
    weak var selectedImageView : UIImageView?
    var animator : ARNTransitionAnimator?
    var isModeInteractive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuVehicleCollectionView()

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
                let controller = storyboard.instantiateViewController(withIdentifier: "CartItemDetailsViewController") as! CartItemDetailsViewController
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
        let controller = storyboard.instantiateViewController(withIdentifier: "CartItemDetailsViewController") as! CartItemDetailsViewController
        
        let animation = ImageZoomAnimation<ImageZoomAnimationVC>(rootVC: self, modalVC: controller, rootNavigation: self.navigationController)
        let animator = ARNTransitionAnimator(duration: 0.5, animation: animation)
        
        let gestureHandler = TransitionGestureHandler(targetView: controller.view, direction: .bottom)
        animator.registerInteractiveTransitioning(.dismiss, gestureHandler: gestureHandler)
        
        controller.transitioningDelegate = animator
        self.animator = animator
        
        self.present(controller, animated: true, completion: nil)
    }
    
    private func setuVehicleCollectionView(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.vehicleCollectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.vehicleCollectionView.register(UINib(nibName: "\(OCTCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: kReuseCellID)
    }
    
    @IBAction func btnBackAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - collection View DataSource
extension CartViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imgNumber = indexPath.item % kTotalImgs + 1
        let imageName = kImgName + "\(imgNumber)"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kReuseCellID, for: indexPath) as! OCTCollectionViewCell
        cell.imgView!.image = UIImage(named: imageName)
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.vehicleCollectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - collection View Delegate
extension CartViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! OCTCollectionViewCell
        self.selectedImageView = cell.imgView
        
        self.handleTransition()
    }
}

