//
//  CollectionTestViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/7/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit


struct Menu: Decodable {

    let data: [MenuStruct]
}

struct MenuStruct: Decodable {
    
    let id: Int
    let parent_id: Int?
    let title: String
    let display_title: String
    let image: String?
    let created_at: String
    let updated_at: String
    let children: [MenuStruct]?
}

struct MenuModel {
    let id: Int
    let title: String
    let displayTitle: String
}


class CollectionTestViewController: UIViewController{
    
    var mainMenus = [MenuModel]()
    var investMenus = [MenuModel]()
    var muesseMenus = [MenuModel]()
    
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var indc: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("COCOCOCO")
        
        let urlString = "http://142.93.186.89/storage/posts/post1.jpg"
        
        guard let url = URL(string: urlString)
            else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            guard let data = data else { return }
            
            do{
                
            }
            
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
            
            if err == nil{
                
                let image = UIImage(data: data)
                if (image == nil)
                {
                    print("Sekil Yoxdur")
                }
                print("HAHAHAHHA")
                DispatchQueue.main.async {
                    self.testImage.image = UIImage(data: data)
                    self.indc.isHidden = true
                }
            }
            
        }.resume()

        
    }
    
    


}
