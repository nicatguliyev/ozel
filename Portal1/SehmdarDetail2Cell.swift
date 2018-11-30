//
//  SehmdarDetail2Cell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/10/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class SehmdarDetail2Cell: UITableViewCell {
    
    
    @IBOutlet weak var sehmdarDetail1Lbl: UILabel!
    @IBOutlet weak var sehmdarDetail2Lbl: UILabel!
    @IBOutlet weak var sehmdarDetail3Lbl: UILabel!
    @IBOutlet weak var sehmdarDetail4Lbl: UILabel!
    @IBOutlet weak var sehmdarConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
