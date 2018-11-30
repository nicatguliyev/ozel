//
//  SehmdarDetail1Cell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/9/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class SehmdarDetail1Cell: UITableViewCell {

    @IBOutlet weak var sehmdarSiraLbl: UILabel!
    @IBOutlet weak var sehmdarNameLbl: UILabel!
    @IBOutlet weak var sehmdarNoLbl: UILabel!
    @IBOutlet weak var sehmdarDateLbl: UILabel!
    @IBOutlet weak var sehmdarParentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
