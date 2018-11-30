//
//  VideoCollectionViewCell.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/11/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var videoIcon: UIImageView!
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    func loadImageFromUrl(id: String){
        
        let  urlString = "https://img.youtube.com/vi/" + id + "/0.jpg"
        
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!){(data, response, err) in
            
            if let content = data {
                
                DispatchQueue.main.async {
                    self.videoImg.image = UIImage(data: content)
                    self.indicator.isHidden = true
                    self.videoIcon.isHidden = false
                }
                
            }
            
            }.resume()
        
    }
    
    
}
