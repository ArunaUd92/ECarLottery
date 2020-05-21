//
//  AnswerPopUpViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/21/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

class AnswerPopUpViewController: UIViewController {

    @IBOutlet weak var answerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        answerTableView.tableFooterView = UIView()
        answerTableView.estimatedRowHeight = 210.0
        answerTableView.rowHeight = UITableView.automaticDimension
        
    }
    
}

// MARK: - Table View DataSource
extension AnswerPopUpViewController: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath) as! AnswerTableViewCell
        cell.lblAnswer.text = "arrLocation[indexPath.row].district"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}

// MARK: - Table View Delegate
extension AnswerPopUpViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
}

