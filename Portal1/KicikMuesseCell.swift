//
//  KicikMuesseCell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/10/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class KicikMuesseCell: UITableViewCell {

    @IBOutlet weak var muesseView: UIView!
    @IBOutlet weak var muesseNo: UILabel!
    @IBOutlet weak var muesseName: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
