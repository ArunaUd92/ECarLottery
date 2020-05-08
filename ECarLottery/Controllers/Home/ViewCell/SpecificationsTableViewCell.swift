//
//  SpecificationsTableViewCell.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/6/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

class SpecificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
