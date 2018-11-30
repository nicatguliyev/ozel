//
//  CustomSifarisCell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/10/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class CustomSifarisCell: UITableViewCell {

   
    @IBOutlet weak var detail2: UILabel!
    @IBOutlet weak var detail1: UILabel!
    @IBOutlet weak var muesseImage: UIImageView!
    @IBOutlet weak var basliqLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
