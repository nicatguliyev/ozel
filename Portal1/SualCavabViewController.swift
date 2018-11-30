//
//  SualCavabViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/12/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

struct QuestionModel: Decodable {
    let data: [QuestionDataModel]
}

struct QuestionDataModel: Decodable {
    let id: Int
    let question: String
    let answer: String
}

class SualCavabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var leftButton = UIButton()
    var rightButton = UIButton()
    var question = [String]()
    var answers = [String]()
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navBarColor = UIColor(red: 13/255, green: 140/255 , blue: 207/255, alpha: 1);
        let navBar = self.navigationController?.navigationBar
        
        navBar?.barTintColor = navBarColor
        navBar?.isTranslucent = false
        
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(exitSualCavab), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)
        
        self.table.isHidden = true
        
        getData()
        
    }
    
    @objc func nothing(){
        
    }
    
    @objc func exitSualCavab()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return question.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SualCavabCellId") as! SualCavabCell
        
        cell.sualLbl.text = "Sual: " + question[indexPath.section]
        cell.cavabLbl.text = "Cavab: " + answers[indexPath.section]
        
        var index1 = 0
        // Tarixi Goy rengde edir
        for char in cell.sualLbl.text! {
            
            if(char != ":")
            {
                index1 = index1 + 1
            }
            else
            {
                break
            }
            
        }
        
        var index2 = 0
        // Tarixi Goy rengde edir
        for char in cell.cavabLbl.text! {
            
            if(char != ":")
            {
                index2 = index2 + 1
            }
            else
            {
                break
            }
            
        }
        
        
        let sualColor = UIColor(red: 255/255, green: 119/255, blue: 0/255, alpha: 1)
        let cavabColor = UIColor(red: 13/255, green: 140/255, blue: 207/255, alpha: 1)

        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: cell.sualLbl.text!, attributes: [NSAttributedStringKey.font:UIFont(name: "Dosis-SemiBold", size: 19.0)!])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: sualColor, range: NSRange(location:0,length:index1 + 1))
        cell.sualLbl.attributedText = myMutableString
        
         var myMutableString2 = NSMutableAttributedString()
         myMutableString2 = NSMutableAttributedString(string: cell.cavabLbl.text!, attributes: [NSAttributedStringKey.font:UIFont(name: "Dosis-SemiBold", size: 19.0)!])
         myMutableString2.addAttribute(NSAttributedStringKey.foregroundColor, value: cavabColor, range: NSRange(location:0,length:index2 + 1))
         cell.cavabLbl.attributedText = myMutableString2
        
        
        cell.layer.cornerRadius = 10
        cell.sualCavabParentView.layer.cornerRadius = 10
        cell.sualCavabParentView.layer.shadowColor = UIColor.black.cgColor
        cell.sualCavabParentView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cell.sualCavabParentView.layer.shadowRadius = 1.7
        cell.sualCavabParentView.layer.shadowOpacity = 0.45
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    func getData() {
        
        let urlString = "http://142.93.186.89/api/v1/questions/index"
      
        guard let url = URL(string: urlString)
            else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            guard let data = data else { return }
            
            
            do{
                let content = try JSONDecoder().decode(QuestionModel.self, from: data)
                
                for i in 0..<content.data.count {
                    self.question.append(content.data[i].question)
                    self.answers.append(content.data[i].answer)
                }
                
            }
                
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
            
            if (err == nil)
            {
                
                DispatchQueue.main.async {
                    
                    self.table.reloadData()
                    self.indicator.isHidden = true
                    self.table.isHidden = false
                    
                }
                
            }
            
            }.resume()
    


    }
}
