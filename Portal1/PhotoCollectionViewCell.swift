//
//  PhotoCollectionViewCell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/11/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoIndicator: UIActivityIndicatorView!
    
    
    func loadImageFromUrl(url: String){
        
        let url = URL(string: url)
        
        URLSession.shared.dataTask(with: url!){(data, response, err) in
            
            if let content = data {
                
                DispatchQueue.main.async {
                    self.photoImage.image = UIImage(data: content)
                    self.photoIndicator.isHidden = true
                }
                
            }
            
        }.resume()
        
    }
    
    override func prepareForReuse() {
        
        
        
    }
    
}
