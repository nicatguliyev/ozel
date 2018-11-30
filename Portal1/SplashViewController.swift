//
//  SplashViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/2/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit


struct  MenuStruct2: Decodable {
    let id: Int
    let parent_id: Int?
    let title: String
    let display_title: String
    let image: String?
    let created_at: String
    let updated_at: String
}

class SplashViewController: UIViewController {
    
    var mainMenus = [MenuModel]()
    var investMenus = [MenuModel]()
    var muesseMenus = [MenuModel]()
    var herracMenus = [MenuModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // print("TOTOTOT")
        
        performSegue(withIdentifier: "showNewsScreen", sender: self)

        
        let urlString = "http://142.93.186.89/api/v1/menus"
        
        guard let url = URL(string: urlString)
            else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
        
            guard let data = data else { return }
            
            do{
                let menu = try JSONDecoder().decode(Menu.self, from: data)
                
                for i in 0..<menu.data.count{
                    let mainMenu = MenuModel(id: menu.data[i].id, title: menu.data[i].title, displayTitle: menu.data[i].display_title)
                    self.mainMenus.append(mainMenu)
                    if(i == 0)
                    {
                        for j in 0..<menu.data[i].children!.count{
                            let investMenu = MenuModel(id: menu.data[i].children![j].id, title: menu.data[i].children![j].title, displayTitle: menu.data[i].children![j].display_title)
                            self.investMenus.append(investMenu)
                        }
                    }
                    if(i == 2){
                        
                        for j in 0..<menu.data[i].children!.count{
                            let herracMenu = MenuModel(id: menu.data[i].children![j].id, title: menu.data[i].children![j].title, displayTitle: menu.data[i].children![j].display_title)
                            self.herracMenus.append(herracMenu)
                            if(j == 1)
                            {
                                let count = menu.data[i].children![j].children!.count
                                
                                for k in 0..<count{
                                    let muesseMenu = MenuModel(id: menu.data[i].children![j].children![k].id, title: menu.data[i].children![j].children![k].title, displayTitle: menu.data[i].children![j].children![k].display_title)
                                    self.muesseMenus.append(muesseMenu)
                                    
                                }
                                
                            }
                            
                        }
                    }
                }
            }
                
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
            
            if(err == nil)
            {
                
                DispatchQueue.main.async {
                    self.perform(#selector(self.showNewsScreen), with: nil, afterDelay: 2)
                }
            }
            
            }.resume()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! MainNavController
        
        let NewsViewController = navVC.viewControllers.first as! NewsViewController
        
        NewsViewController.mainMenus = self.mainMenus
        NewsViewController.investMenus = self.investMenus
        NewsViewController.muesseMenus = self.muesseMenus
        NewsViewController.herracMenus = self.herracMenus
        
    }
    
    
    @objc func showNewsScreen(){
        UIView.setAnimationsEnabled(true)
        performSegue(withIdentifier: "showNewsScreen", sender: self)
        UIView.setAnimationsEnabled(true)
    }


}
