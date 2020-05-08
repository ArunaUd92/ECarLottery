//
//  CartItemDetailsViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/8/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

class CartItemDetailsViewController: ImageZoomAnimationVC {

     @IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func tapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
