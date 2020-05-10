//
//  MenuTableViewCell.swift
//  AddHunters
//
//  Created by Aruna Udayanga on 12/31/19.
//  Copyright © 2019 keeneye solutions. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var ivMenuImage: UIImageView!
    @IBOutlet weak var lblMenuText: UILabel!
    @IBOutlet weak var imageBaseView: UIView!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
