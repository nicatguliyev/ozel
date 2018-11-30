//
//  SehmdarDetail2Controller.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/10/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class SehmdarDetail2Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let detailNames = ["Sehmdar cemiyyetin adi ve tesis tarixi",
                       "Sehmdar cemiyyetin huququ unvani",
                       "Nizamname kapitalinin hecmi(manat)",
                       "Bir sehmin nominal qiymeti(manat)",
                       "Satisa cixarilmis sehmler sayi(manat)",
                       "Buraxilmis sehmlerin umumi sayinda %-le",
                       "Satisa cixarilan sehmlerin nominal deyeri(manat)",
                       "Satisa cixarilan sehmlerin ilkin herac qiymeti(manat)"]
    let detailValues = ["Berde KendKimya", "berde Seheri, Senaye kucesi ev-23, menzil-9 filan yer filan yer",
                        "1245930",
                        "2.00",
                        "28764.00",
                        "30.3",
                        "87467.00",
                        "456782.00"]
    
    var leftButton = UIButton()
    var rightButton = UIButton()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(exitSehmdarDetailController), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)

    }
    
    @objc func exitSehmdarDetailController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func nothing(){
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailValues.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            var cell1: CustomSehmDetail2Cell! = tableView.dequeueReusableCell(withIdentifier: "CustomCell1") as? CustomSehmDetail2Cell
            if(cell1 == nil)
            {
                let nib: [CustomSehmDetail2Cell] = Bundle.main.loadNibNamed("CustomSehmDetail2Cell", owner: self, options: nil) as! [CustomSehmDetail2Cell]
                cell1 = nib[0]
                
                cell1.selectionStyle = .none
                
            }
            return cell1
        }
            
        else {
            
            var cell2: CustomSehmDetail2Cell! = tableView.dequeueReusableCell(withIdentifier: "CustomCell2") as? CustomSehmDetail2Cell
            if(cell2 == nil)
            {
                let nib: [CustomSehmDetail2Cell] = Bundle.main.loadNibNamed("CustomSehmDetail2Cell", owner: self, options: nil) as! [CustomSehmDetail2Cell]
                cell2 = nib[1]
                
               if(indexPath.row != 1)
               {
                   cell2.constraint.constant = 0
                }
            cell2.detailName.text = self.detailNames[indexPath.row - 1]
                cell2.detailValue1.text  = self.detailValues[indexPath.row - 1]
            
            
        }
            
            return cell2
    }
    

    }

}
