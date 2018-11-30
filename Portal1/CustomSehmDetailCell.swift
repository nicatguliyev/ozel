//
//  CustomSehmDetailCell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/17/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class CustomSehmDetailCell: UITableViewCell {

    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var listNumber: UILabel!
    @IBOutlet weak var listItemName: UILabel!
    @IBOutlet weak var listItemDetail1: UILabel!
    @IBOutlet weak var listItemDetail2: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
