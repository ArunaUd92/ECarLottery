//
//  LeftSlideMenuViewController.swift
//  Gamata
//
//  Created by Aruna Udayanga on 3/24/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

struct SliderMenu {
    var name: String = ""
    var imageName: String = ""
}

class LeftSlideMenuViewController: UIViewController {
    
    @IBOutlet var viewLeftMenuFullView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var backgroundTapView: UIView!
    
    var menuList: [SliderMenu] = []
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.view.isOpaque = false
        
        let backgroundViewTap = UITapGestureRecognizer(target: self, action: #selector(addBackgroundViewTapped(sender:)))
        self.backgroundTapView.isUserInteractionEnabled = true
        self.backgroundTapView.addGestureRecognizer(backgroundViewTap)
        
        setMenuList()
    }
    
    func setMenuList(){
        
        self.menuList.append(SliderMenu.init(name: "Home", imageName: "ic_language"))
        self.menuList.append(SliderMenu.init(name: "Raffle Listings", imageName: "ic_product"))
        self.menuList.append(SliderMenu.init(name: "Raffle Winners", imageName: "ic_location"))
        self.menuList.append(SliderMenu.init(name: "Previous Draws", imageName: "ic_user_reg"))
        self.menuList.append(SliderMenu.init(name: "My Account", imageName: "ic_user_reg"))
        self.menuList.append(SliderMenu.init(name: "Terms & Conditions", imageName: "ic_info"))
        self.menuList.append(SliderMenu.init(name: "How its Works", imageName: "ic_signout"))
        self.menuList.append(SliderMenu.init(name: "Sign Out", imageName: "ic_signout"))
        
    }
    
    func animationView(){
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.curveEaseOut], animations: { () -> Void in
            self.viewLeftMenuFullView.frame = CGRect(x: self.viewLeftMenuFullView.frame.origin.x, y: self.viewLeftMenuFullView.frame.origin.y ,width: self.viewLeftMenuFullView.frame.size.width ,height: self.viewLeftMenuFullView.frame.size.height)
        }, completion: { (finished: Bool) -> Void in
            
        })
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        
    }
    
    @objc func addBackgroundViewTapped(sender: Any){
        animation(viewAnimation: viewLeftMenuFullView)
    }
    
    
    private func animation(viewAnimation: UIView) {
        
        UIView.animate(withDuration: 0.4, delay: 0.4, options: [.curveEaseIn], animations: {
            viewAnimation.frame.origin.x -= viewAnimation.frame.width
            
        }, completion: {(finished:Bool) in
            // the code you put here will be compiled once the animation finishes
            self.dismiss(animated: false, completion: nil)
        })
    }

}

// MARK: - Table View DataSource
extension LeftSlideMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let menuItem = menuList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.lblMenuText.text! =  menuList[indexPath.row].name
        cell.ivMenuImage.image = UIImage(named: menuList[indexPath.row].imageName)
        
        cell.ivMenuImage.image = cell.ivMenuImage.image?.withRenderingMode(.alwaysTemplate)
        cell.ivMenuImage.tintColor = UIColor.gray
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - Table View Delegate
extension LeftSlideMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0){
            weak var pvc = self.presentingViewController
            self.dismiss(animated: false, completion: {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                homeVC.modalPresentationStyle =  .fullScreen
                pvc?.present(homeVC, animated: false, completion: nil)
            })
        } else if(indexPath.row == 1){
            weak var pvc = self.presentingViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let raffleListingsVC = storyboard.instantiateViewController(withIdentifier: "RaffleListingsViewController") as! RaffleListingsViewController
            raffleListingsVC.modalPresentationStyle =  .fullScreen
            pvc?.present(raffleListingsVC, animated: false, completion: nil)
        }
    }
}

class AnimationView: UIView {
    enum Direction: Int {
        case FromLeft = 0
        case FromRight = 1
    }
    
    @IBInspectable var direction : Int = 0
    @IBInspectable var delay :Double = 0.0
    @IBInspectable var duration :Double = 0.0
    override func layoutSubviews() {
        initialSetup()
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            if let superview = self.superview {
                if self.direction == Direction.FromLeft.rawValue {
                    self.center.x += superview.bounds.width
                } else {
                    self.center.x -= superview.bounds.width
                }
            }
        })
    }
    func initialSetup() {
        if let superview = self.superview {
            if direction == Direction.FromLeft.rawValue {
                self.center.x -= superview.bounds.width
            } else {
                self.center.x += superview.bounds.width
            }
        }
    }
}
