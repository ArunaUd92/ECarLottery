//
//  MenuViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/10/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

//struct SliderMenu {
//    var name: String = ""
//    var imageName: String = ""
//}

class MenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!
    
    var menuList: [SliderMenu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMenuList()
    }
    
    func setMenuList(){
        
        self.menuList.append(SliderMenu.init(name: "Home", imageName: "home_slider"))
        self.menuList.append(SliderMenu.init(name: "Raffle Listings", imageName: "Raffle Listings"))
        self.menuList.append(SliderMenu.init(name: "Raffle Winners", imageName: "Raffle Winners"))
        self.menuList.append(SliderMenu.init(name: "Previous Draws", imageName: "Previous Draws"))
        self.menuList.append(SliderMenu.init(name: "My Account", imageName: "My Account"))
        self.menuList.append(SliderMenu.init(name: "Terms & Conditions", imageName: "Terms & Conditions"))
        self.menuList.append(SliderMenu.init(name: "How its Works", imageName: "How its Works"))
        self.menuList.append(SliderMenu.init(name: "About Us", imageName: "about_us_slider"))
        self.menuList.append(SliderMenu.init(name: "Sign Out", imageName: "contact_us_slider"))
        
    }

}

// MARK: - Table View DataSource
extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menu = menuList[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        cell.lblMenuText.text! =  menuList[indexPath.row].name
        cell.ivMenuImage.image = UIImage(named: menuList[indexPath.row].imageName)
        
       // cell.baseView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        cell.ivMenuImage.image = cell.ivMenuImage.image?.withRenderingMode(.alwaysTemplate)
        cell.ivMenuImage.tintColor = UIColor.init(hexString: "#FFFFFF")
        cell.lblMenuText.textColor = UIColor.init(hexString: "#464c53")
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - Table View Delegate
extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
//        if indexPath.row == 1 {
//            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
//            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
//
//        }  else if (indexPath.row == 2){
//
//            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "PropertyListViewController") as! PropertyListViewController
//            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
//            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
//        }
    }
}
