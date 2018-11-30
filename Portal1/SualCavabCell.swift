//
//  SualCavabCell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/12/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class SualCavabCell: UITableViewCell {

   
    @IBOutlet weak var cavabLbl: UILabel!
    @IBOutlet weak var sualLbl: UILabel!
    @IBOutlet weak var sualCavabParentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
