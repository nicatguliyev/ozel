//
//  YardimTableViewCell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/5/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class YardimTableViewCell: UITableViewCell {

   
    @IBOutlet weak var menbeLbl: UILabel!
    @IBOutlet weak var yardimLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
