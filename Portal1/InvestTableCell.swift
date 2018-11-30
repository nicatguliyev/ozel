//
//  InvestTableCell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/8/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class InvestTableCell: UITableViewCell {

    @IBOutlet weak var investNameLbl: UILabel!
    
    @IBOutlet weak var sehmdarNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}
