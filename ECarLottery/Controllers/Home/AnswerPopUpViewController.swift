//
//  AnswerPopUpViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/21/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

protocol CorrectAnswerDelegate {
    func setCorrectAnswerAction(answerObject: Answer)
}

class AnswerPopUpViewController: UIViewController {

    @IBOutlet weak var answerTableView: SelfSizedTableView!
    
    var answerList: [Answer] = []
    var correctAnswerDelegate: CorrectAnswerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        answerTableView.tableFooterView = UIView()
        
        answerTableView.estimatedRowHeight = 44.0
        answerTableView.rowHeight = UITableView.automaticDimension

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        answerTableView.maxHeight = 375
        answerTableView.reloadData()
    }
    
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table View DataSource
extension AnswerPopUpViewController: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath) as! AnswerTableViewCell
        let answerObj = self.answerList[indexPath.row]
        cell.lblAnswer.text = answerObj.answer
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.answerList.count
    }
    
}

// MARK: - Table View Delegate
extension AnswerPopUpViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answerObj = self.answerList[indexPath.row]
        correctAnswerDelegate.setCorrectAnswerAction(answerObject: answerObj)
        dismiss(animated: true, completion: nil)
    }
}

