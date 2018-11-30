//
//  InvestViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/8/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit


struct InvestItemList: Decodable {
    let data: [InvestListItemModel]
}

struct InvestListItemModel: Decodable {
    let id: Int
    let title: String
}

class InvestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedMenu: MenuModel?
    var investItemList = [InvestListItemModel]()
    var clickedListId = 0

    @IBOutlet weak var investTable: UITableView!
    @IBOutlet weak var splashHeight: NSLayoutConstraint!
    @IBOutlet weak var splashIndicator: UIActivityIndicatorView!
    @IBOutlet weak var reloadView: UIView!
    @IBOutlet weak var splashScreen: UIView!
    
    var leftButton = UIButton()
    var rightButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarColor = UIColor(red: 13/255, green: 140/255 , blue: 207/255, alpha: 1);
        let navBar = self.navigationController?.navigationBar
        
        navBar?.barTintColor = navBarColor
        navBar?.isTranslucent = false
        
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(existInvestController), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)
        
        view.bringSubview(toFront: splashScreen)
        splashHeight.constant = UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.size.height)!
        
        getData()
        
        
        let reloadGesture = UITapGestureRecognizer(target: self, action: #selector(reloadTapped))
        reloadView.addGestureRecognizer(reloadGesture)
        reloadView.isUserInteractionEnabled = true
        
    /*    let urlString = "http://142.93.186.89/api/v1/content/list/" + "\(selectedMenu!.id)"
        
        guard let url = URL(string: urlString)
            else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
          
            
            guard let data = data else { return }
            
            do{
                let list = try JSONDecoder().decode(InvestItemList.self, from: data)
                
                for i in 0..<list.data.count{
                    let itemModel = InvestListItemModel(id: list.data[i].id, title: list.data[i].title)
                    self.investItemList.append(itemModel)
                    
                }
                
            }
                
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
            
            if(err == nil)
            {
                DispatchQueue.main.async {
                    self.investTable.reloadData()
                    self.investTable.isHidden = false
                   // self.indicator.isHidden = true
                }
            
            }
            
            }.resume() */
        

    }
    
    @objc func reloadTapped(){
        getData()
    }
    
    
    @objc func existInvestController(){
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func nothing(){
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.investItemList.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        if(indexPath.section == 0)
        {
            var cell1: CustomInvestCell! = tableView.dequeueReusableCell(withIdentifier: "investCell2") as? CustomInvestCell
            if(cell1 == nil)
            {
                let nib: [CustomInvestCell] = Bundle.main.loadNibNamed("CustomInvestCell", owner: self, options: nil) as! [CustomInvestCell]
                cell1 = nib[2]
                
                cell1.selectionStyle = .none
                cell1.listName.text = selectedMenu!.displayTitle

            }
            return cell1
        }
        
        else {
            
            var cell2: CustomInvestCell! = tableView.dequeueReusableCell(withIdentifier: "investCell1") as? CustomInvestCell
            if(cell2 == nil)
            {
                let nib: [CustomInvestCell] = Bundle.main.loadNibNamed("CustomInvestCell", owner: self, options: nil) as! [CustomInvestCell]
                cell2 = nib[1]
 
                for i in 0..<self.investItemList.count {
                    if (i == indexPath.section - 1)
                    {
                        cell2.listItemName.text = self.investItemList[i].title
                    }
            }
                
                cell2.layer.borderWidth = 2
                cell2.layer.borderColor = UIColor(red: 13/255, green: 140/255, blue: 207/255, alpha: 1).cgColor
                cell2.layer.cornerRadius = 10
                cell2.backgroundColor = UIColor.clear
            
        }
            
            return cell2
        
        }
    }
    
    
    func getData(){
        
        self.splashScreen.isHidden = false
        self.reloadView.isHidden = true
        self.splashIndicator.isHidden = false
        
        let urlString = "http://142.93.186.89/api/v1/content/list/" + "\(selectedMenu!.id)"
        
        guard let url = URL(string: urlString)
            else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            if(err == nil){
            
            guard let data = data else { return }
            
            do{
                let list = try JSONDecoder().decode(InvestItemList.self, from: data)
                
                for i in 0..<list.data.count{
                    let itemModel = InvestListItemModel(id: list.data[i].id, title: list.data[i].title)
                    self.investItemList.append(itemModel)
                    
                }
                
            }
                
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
            
            if(err == nil)
            {
                DispatchQueue.main.async {
                    self.investTable.reloadData()
                    self.investTable.isHidden = false
                    self.splashScreen.isHidden = true
                    // self.indicator.isHidden = true
                }
                
            }
            }
            else{
                
                if let error = err as? NSError
                {
                    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorCannotConnectToHost{
                        DispatchQueue.main.async {
                            
                            self.splashScreen.isHidden = false
                            self.reloadView.isHidden = false
                            self.splashIndicator.isHidden = true
                            //self.investTable.isHidden = false
                            
                        }
                    }
                }
                }
                
            }.resume()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.section != 0)
        {
            self.clickedListId = self.investItemList[indexPath.section - 1].id
           performSegue(withIdentifier: "segueToInvestDetail", sender: self)
            
           // self.clickedListId = self.investItemList[indexPath.row].id
            
           
        }
               
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToInvestDetail"
        {
            let destinationVC = segue.destination as! InvestDetailController
            
            //destinationVC.deta = self.selectedSlideImage
            
           destinationVC.detailId = "\(self.clickedListId)"
            
        }
    }

    
    

}
