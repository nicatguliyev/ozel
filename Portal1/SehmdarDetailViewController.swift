//
//  SehmdarDetailViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/9/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

struct HerracDetailModel2: Decodable {
    let  data: [HerracDetailDataModel2]
}

struct HerracDetailDataModel2: Decodable
{
    let id: Int
    let title: String
    let number: Int
    let date: String
}

class SehmdarDetailViewController: UIViewController, UITableViewDelegate,
UITableViewDataSource{
    
    var sehmdarModels = [SehmdarModel1]()
    @IBOutlet weak var sehmdarTable: UITableView!
    @IBOutlet weak var sehmdarTitleLbl: UILabel!
    var index = 0
    var leftButton = UIButton()
    var rightButton = UIButton()
    var titles = [String]()
    var idFromFirstList = 0
    var detailLists = [HerracDetailDataModel2]()
    var selectedModel: HerracDetailDataModel2?
    var selectedItemList: HerracDetailDataModel1?
    var selectedMenu: MenuModel?
    
    @IBOutlet weak var splashIndicator: UIActivityIndicatorView!
    @IBOutlet weak var splashHeight: NSLayoutConstraint!
    @IBOutlet weak var splashScreen: UIView!
    @IBOutlet weak var reloadView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let navBarColor = UIColor(red: 13/255, green: 140/255 , blue: 207/255, alpha: 1);
        let navBar = self.navigationController?.navigationBar
        
        navBar?.barTintColor = navBarColor
        navBar?.isTranslucent = false
        self.navigationItem.title = "Ozellesdirme Portali"
       
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(exitSehmdarDetailController), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)
        
        view.bringSubview(toFront: splashScreen)
        splashHeight.constant = UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.size.height)!
        
        getData()
        
        let reloadGesture = UITapGestureRecognizer(target: self, action: #selector(reloadTapped))
        reloadView.addGestureRecognizer(reloadGesture)
        reloadView.isUserInteractionEnabled = true

        
    }
    
    @objc func reloadTapped(){
        getData()
    }
    
    @objc func exitSehmdarDetailController(){
        self.navigationController?.popViewController(animated: true)

    }
    
    @objc func nothing(){
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return detailLists.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0 || section == 1)
        {
            return 0
        }
        else
        {
        return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0 || indexPath.section == 1)
        {
            var cell1: CustomSehmDetailCell! = tableView.dequeueReusableCell(withIdentifier: "CustomCell1") as? CustomSehmDetailCell
            if(cell1 == nil)
            {
                let nib: [CustomSehmDetailCell] = Bundle.main.loadNibNamed("CustomSehmDetailCell", owner: self, options: nil) as! [CustomSehmDetailCell]
                cell1 = nib[0]
                
                cell1.selectionStyle = .none
                
                if(indexPath.section == 1)
                {
                    var index = 0
                    let count = selectedItemList?.title
                    
                    if let count = count{
                    for char in count {
                        
                        if(char != "-")
                        {
                            index = index + 1
                        }
                        else
                        {
                            break
                        }
                        
                    }
                    let dateColor = UIColor(red: 13/255, green: 140/255, blue: 207/255, alpha: 1)
                    var myMutableString = NSMutableAttributedString()
                        myMutableString = NSMutableAttributedString(string: (selectedItemList?.title)!, attributes: [NSAttributedStringKey.font:UIFont(name: "Dosis-SemiBold", size: 19.0)!])
                    myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: dateColor, range: NSRange(location:0,length:index - 1))
                    cell1.listName.attributedText = myMutableString
                    cell1.bottomConstraint.constant = 8
                    }
                }
                else
                {
                    cell1.listName.text = selectedMenu?.displayTitle
                    cell1.topConstraint.constant = 8
                }
                
            }
            return cell1
        }
            
        else {
            
            var cell2: CustomSehmDetailCell! = tableView.dequeueReusableCell(withIdentifier: "CustomCell2") as? CustomSehmDetailCell
            if(cell2 == nil)
            {
                let nib: [CustomSehmDetailCell] = Bundle.main.loadNibNamed("CustomSehmDetailCell", owner: self, options: nil) as! [CustomSehmDetailCell]
                cell2 = nib[1]
                
                for i in 0..<self.detailLists.count {
                    if (i == indexPath.section - 2)
                    {
                        //cell2.listItemName.text = self.investNames[i]
                        cell2.listItemName.text = self.detailLists[i].title
                        cell2.listNumber.text = "\(i + 1)."
                        cell2.listItemDetail1.text = "№" + "\(self.detailLists[i].number)"
                        cell2.listItemDetail2.text = self.detailLists[i].date
                    }
                }
                
                cell2.layer.cornerRadius = 10
                cell2.parentView.layer.cornerRadius = 10
                cell2.parentView.layer.shadowColor = UIColor.black.cgColor
                cell2.parentView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
                cell2.parentView.layer.shadowRadius = 1.7
                cell2.parentView.layer.shadowOpacity = 0.45
                
            }
            
            return cell2
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.section != 0 && indexPath.section != 1)
        {
            self.selectedModel =  detailLists[indexPath.section - 2]
            performSegue(withIdentifier: "SegueToDetail2", sender: self)
        }
    }
    
    func getData() {
        
        let urlString = "http://142.93.186.89/api/v1/auctions/category/\(idFromFirstList)"
        self.reloadView.isHidden = true
        self.splashIndicator.isHidden = false
        
        
        guard let url = URL(string: urlString)
            else {return}
        
        
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            if(err == nil){
            guard let data = data else { return }
            
            
            do{
                let content = try JSONDecoder().decode(HerracDetailModel2.self, from: data)
                
                for i in 0..<content.data.count {
                    self.detailLists.append(content.data[i])
                    print(content.data[i])
                }
                
            }
                
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
            
             
                DispatchQueue.main.async {
                    
                   print(self.detailLists)
                    self.sehmdarTable.reloadData()
                    self.splashScreen.isHidden = true
                    self.reloadView.isHidden = true
                    
                }
                
            }
            
            else
            {
                if let error = err as? NSError
                {
                    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorCannotConnectToHost {
                        DispatchQueue.main.async {
                        
                            self.splashScreen.isHidden = false
                            self.reloadView.isHidden = false
                            self.splashIndicator.isHidden = true
                            self.sehmdarTable.isHidden = false
                            
                        }
                    }
                   
                }
            }
            
            }.resume()
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToDetail2"
        {
            let destinationVC = segue.destination as! SifarisController
            
            destinationVC.selectedModel = self.selectedModel
            
        }
    }

}
