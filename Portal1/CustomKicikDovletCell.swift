//
//  CustomKicikDovletCell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/17/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class CustomKicikDovletCell: UITableViewCell {

    @IBOutlet weak var basliqLbl: UILabel!
    @IBOutlet weak var listNo: UILabel!
    @IBOutlet weak var listItemName: UILabel!
    @IBOutlet weak var parentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
