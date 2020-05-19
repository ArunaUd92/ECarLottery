//
//  YourCartTableViewCell.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/13/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

class YourCartTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.mainImageVIew.roundCorners(corners: [.topLeft, .topRight], radius: 11)
        self.mainImageVIew.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
