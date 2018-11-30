//
//  KicikDovletController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/10/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class KicikDovletController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var muesseListLbl: UILabel!
    var leftButton = UIButton()
    var rightButton = UIButton()
    var titles = [String]()
    
    var muesseArray = ["Bakı şəhər, Binəqədi rayonu, M.Ə.Rəsulzadə qəsəbəsi, M.Davudoğlu küç, 16, 9 saylı mağaza",
                       "Bakı şəhər, Binəqədi rayonu, M.Ə.Rəsulzadə qəsəbəsi, M.Davudoğlu küç, 16, 9 saylı mağaza",
                       "Bakı şəhər, Qaradağ rayonu,Qobustan qəsəbəsi Bakı-Salyan yolu, Qobustan qəs, Avtotəmir (avadanlıq)",
                       "Bakı şəhəri, Qaradağ rayonu, Ələt qəsəbəsi, A.Abdullayev küçəsi, 8Q, 13 saylı mağaza"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarColor = UIColor(red: 13/255, green: 140/255 , blue: 207/255, alpha: 1);
        let navBar = self.navigationController?.navigationBar
        
        navBar?.barTintColor = navBarColor
        navBar?.isTranslucent = false
        self.navigationItem.title = "Ozellesdirme Portali"
        
        titles.append("Herraclar / Kicik Dovlet Muessiseleri")
        titles.append("30 oktyabr 2018-ci il tarixdə həraca çıxarlacaq kiçik dövlət müəssisə və obyektlərinin siyahısı")
        
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(exitKicikDovletController), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)
        
        
   /*     var index = 0
        // Tarixi Goy rengde edir
        for char in muesseListLbl.text! {
            
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
        myMutableString = NSMutableAttributedString(string: muesseListLbl.text!, attributes: [NSAttributedStringKey.font:UIFont(name: "Dosis-SemiBold", size: 19.0)!])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: dateColor, range: NSRange(location:0,length:index))
        muesseListLbl.attributedText = myMutableString  */
        
    }
    
    @objc func exitKicikDovletController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func nothing(){
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return muesseArray.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      /*  let cell = tableView.dequeueReusableCell(withIdentifier: "kicikDovletCell") as! KicikMuesseCell
        
        for i in 0..<self.muesseArray.count {
            if (i == indexPath.section)
            {
                cell.muesseName.text = self.muesseArray[i]
                cell.muesseNo.text = "\(i+1)."
            }
        }
        
        cell.layer.cornerRadius = 10
        cell.muesseView.layer.cornerRadius = 10
        cell.muesseView.layer.shadowColor = UIColor.black.cgColor
        cell.muesseView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cell.muesseView.layer.shadowRadius = 1.7
        cell.muesseView.layer.shadowOpacity = 0.45
        
        return cell  */
        
        
        if(indexPath.section == 0 || indexPath.section == 1)
        {
            var cell1: CustomKicikDovletCell! = tableView.dequeueReusableCell(withIdentifier: "CustomCell1") as? CustomKicikDovletCell
            if(cell1 == nil)
            {
                let nib: [CustomKicikDovletCell] = Bundle.main.loadNibNamed("CustomKicikDovletCell", owner: self, options: nil) as! [CustomKicikDovletCell]
                cell1 = nib[0]
                
                cell1.selectionStyle = .none
                
                if(indexPath.section == 1)
                {
                    var index = 0
                    for char in titles[1] {
                        
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
                    myMutableString = NSMutableAttributedString(string: titles[1], attributes: [NSAttributedStringKey.font:UIFont(name: "Dosis-SemiBold", size: 19.0)!])
                    myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: dateColor, range: NSRange(location:0,length:index - 1))
                    cell1.basliqLbl.attributedText = myMutableString
                }
                else
                {
                    cell1.basliqLbl.text = titles[0]
                }
                
            }
            return cell1
        }
            
        else {
            
            var cell2: CustomKicikDovletCell! = tableView.dequeueReusableCell(withIdentifier: "CustomCell2") as? CustomKicikDovletCell
            if(cell2 == nil)
            {
                let nib: [CustomKicikDovletCell] = Bundle.main.loadNibNamed("CustomKicikDovletCell", owner: self, options: nil) as! [CustomKicikDovletCell]
                cell2 = nib[1]
                
                for i in 0..<self.muesseArray.count {
                    if (i == indexPath.section - 2)
                    {
                        //cell2.listItemName.text = self.investNames[i]
                        cell2.listItemName.text = self.muesseArray[i]
                        cell2.listNo.text = "\(i + 1)."
                       
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.section != 0 && indexPath.section != 1)
        {
            performSegue(withIdentifier: "SegueToSifaris", sender: self)
        }
    }
    
    

}
