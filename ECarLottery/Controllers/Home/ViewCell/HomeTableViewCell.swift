//
//  HomeTableViewCell.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 4/26/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var vehicleImageView1: UIImageView!
    @IBOutlet weak var mainBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
