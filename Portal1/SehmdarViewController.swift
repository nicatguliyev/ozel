//
//  SehmdarViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/9/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

struct HerracDetailModel1: Decodable {
    let data: [HerracDetailDataModel1]
}

struct HerracDetailDataModel1: Decodable {
    let id: Int
    let title: String
}

class SehmdarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var leftButton = UIButton()
    var rightButton = UIButton()
    var detailLists = [HerracDetailDataModel1]()
    var listItemId = 0
    var selectedMenu: MenuModel?
    var selectedListItem: HerracDetailDataModel1?
    
    @IBOutlet weak var splashIndicator: UIActivityIndicatorView!
    @IBOutlet weak var reloadView: UIView!
    @IBOutlet weak var spalshScreen: UIView!
    @IBOutlet weak var splashHeight: NSLayoutConstraint!
    
    @IBOutlet weak var table: UITableView!
    var parameterFromOut = "1"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let navBarColor = UIColor(red: 13/255, green: 140/255 , blue: 207/255, alpha: 1);
        let navBar = self.navigationController?.navigationBar
        
        navBar?.barTintColor = navBarColor
        navBar?.isTranslucent = false
    
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(exitSehmdarController), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)
        
        view.bringSubview(toFront: spalshScreen)
        splashHeight.constant = UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.height)!
        table.isHidden = true
        
        getData()
        
        let reloadGesture = UITapGestureRecognizer(target: self, action: #selector(reloadTapped))
        reloadView.addGestureRecognizer(reloadGesture)
        reloadView.isUserInteractionEnabled = true
        
    }
    
    @objc func reloadTapped(){
        getData()
    }

    @objc func exitSehmdarController(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func nothing() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return detailLists.count + 1
        
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
                cell1.listName.text = selectedMenu?.displayTitle
                
            }
            return cell1
        }
            
        else {
            
            var cell2: CustomInvestCell! = tableView.dequeueReusableCell(withIdentifier: "investCell1") as? CustomInvestCell
            if(cell2 == nil)
            {
                let nib: [CustomInvestCell] = Bundle.main.loadNibNamed("CustomInvestCell", owner: self, options: nil) as! [CustomInvestCell]
                
                cell2 = nib[1]
                
                
                let dateColor = UIColor(red: 13/255, green: 140/255, blue: 207/255, alpha: 1)
            
                    for i in 0..<self.detailLists.count {
                        var index = 0
                        if (i == indexPath.section - 1)
                        {
                            cell2.listItemName.text = self.detailLists[i].title
                            for char in self.detailLists[i].title
                            {
                                if(char != "-")
                                {
                                    index = index + 1
                                }
                                else
                                {
                                    break
                                }
                            }
                            
                            var myMutableString = NSMutableAttributedString()
                            myMutableString = NSMutableAttributedString(string: self.detailLists[i].title, attributes: [NSAttributedStringKey.font:UIFont(name: "Dosis-Medium", size: 19.0)!])
                            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: dateColor, range: NSRange(location:0,length:index))
                            cell2.listItemName.attributedText = myMutableString
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        listItemId = detailLists[indexPath.section - 1].id
        selectedListItem = detailLists[indexPath.section - 1]
        if(indexPath.section != 0)
        {
            performSegue(withIdentifier: "firstTypeSegue", sender: self)
            
        }
            
        
    }
    
    func getData() {
        
        let urlString = "http://142.93.186.89/api/v1/auctions/list/\((selectedMenu?.id)!)"
        reloadView.isHidden = true
        splashIndicator.isHidden = false
        
        guard let url = URL(string: urlString)
            else {return}
        
      URLSession.shared.dataTask(with: url){ (data, response, error) in
        
        
        if(error == nil){
            
            guard let data = data else { return }
        
            do{
                let content = try JSONDecoder().decode(HerracDetailModel1.self, from: data)
                for i in 0..<content.data.count {
                    self.detailLists.append(content.data[i])
                    print(content.data[i])
                }
                
            }
                
            catch let jsonError{
                print(jsonError)
            }
        
                DispatchQueue.main.async {
                    print("Isledi")
                    self.table.reloadData()
                    self.spalshScreen.isHidden = true
                    self.reloadView.isHidden = true
                    self.table.isHidden = false
       
                }
            
        }
        else {
            if let error = error as? NSError
             {
                if error.code == NSURLErrorNotConnectedToInternet{
                    DispatchQueue.main.async {
                        
                       // self.table.reloadData()
                        self.spalshScreen.isHidden = false
                        self.reloadView.isHidden = false
                        self.splashIndicator.isHidden = true
                        self.table.isHidden = false
                        
                    }
                }
                else if error.code == NSURLErrorCannotConnectToHost
                {
                    DispatchQueue.main.async {
                        self.spalshScreen.isHidden = false
                        self.reloadView.isHidden = false
                        self.splashIndicator.isHidden = true
                        self.table.isHidden = false
                        
                    }
                }
             }
        }
        

    
            }.resume()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "firstTypeSegue"
        {
            let destinationVC = segue.destination as! SehmdarDetailViewController
            
            destinationVC.idFromFirstList = self.listItemId
            destinationVC.selectedMenu = self.selectedMenu
            destinationVC.selectedItemList = self.selectedListItem
            
        }
    }
    



}
