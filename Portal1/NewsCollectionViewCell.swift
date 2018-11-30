//
//  NewsCollectionViewCell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/6/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsNameLbl: UILabel!
    @IBOutlet weak var readmoreBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    
    func loadImageFromUrl(url: String){
        
        let url = URL(string: url)
        self.newsImage.image = nil
        self.contentView.bringSubview(toFront: self.imageIndicator)
        
        URLSession.shared.dataTask(with: url!){(data, response, err) in
            
            if let content = data {
                
                DispatchQueue.main.async {
                    self.newsImage.image = UIImage(data: content)
                    self.imageIndicator.isHidden = true
                    self.newsImage.isHidden = false
                }
                
            }
            
            }.resume()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImage.image = nil
    }
    
}
