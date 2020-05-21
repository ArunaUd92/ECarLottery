//
//  AnswerTableViewCell.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/21/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAnswer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
