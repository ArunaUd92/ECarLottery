//
//  HomeTableViewCell.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 4/26/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var vehicleImageView: UIImageView!
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var lblVehicleName: UILabel!
    @IBOutlet weak var lblVehicleYear: UILabel!
    @IBOutlet weak var lblVehiclePrice: UILabel!
    @IBOutlet weak var lblVehicleMileage: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
