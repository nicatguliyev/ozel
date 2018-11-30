//
//  CustomSehmDetail2Cell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/17/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class CustomSehmDetail2Cell: UITableViewCell {

    @IBOutlet weak var sehmdarName: UILabel!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailValue1: UILabel!
    @IBOutlet weak var detailvalue2: UILabel!
    @IBOutlet weak var detailValue3: UILabel!
    @IBOutlet weak var constraint: NSLayoutConstraint!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
