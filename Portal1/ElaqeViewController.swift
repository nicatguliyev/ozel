//
//  ElaqeViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/11/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit
import SwiftyButton

class ElaqeViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var gonderBtn: FlatButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mekanLbl: UILabel!
    @IBOutlet weak var nameLbl: UITextField!
    
    @IBOutlet weak var mailLbl: UITextField!
    

    
    @IBOutlet weak var textLbl: UITextView!
    var leftButton = UIButton()
    var rightButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fields = [nameLbl, mailLbl]
        
        mekanLbl.layer.cornerRadius = 10
        mekanLbl.layer.masksToBounds = true
       // sendLbl.layer.cornerRadius = 10
       // sendLbl.layer.masksToBounds = true
        
        textLbl.layer.borderColor =  UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.16).cgColor
        textLbl.layer.borderWidth = 1.5
        textLbl.layer.cornerRadius = 10
        textLbl.layer.masksToBounds = true
        
        textLbl.textColor = UIColor.black
        gonderBtn.layer.cornerRadius = 10
        gonderBtn.layer.masksToBounds = true
        
       // GonderView.layer.cornerRadius = 10
        
       // GonderView.bringSubview(toFront: gonderBtn)
        
        let borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.16).cgColor
      
        
        for item in fields {
            item?.layer.borderColor = borderColor
            item?.layer.borderWidth = 1.5
            item?.layer.cornerRadius = 10
            item?.layer.masksToBounds = true
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismisKeyboard))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
        let navBarColor = UIColor(red: 13/255, green: 140/255 , blue: 207/255, alpha: 1);
        let navBar = self.navigationController?.navigationBar
        
        navBar?.barTintColor = navBarColor
        navBar?.isTranslucent = false
   
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(exitElaqe), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)
        
    }
    
    @objc func exitElaqe()
    {
       // self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func dismisKeyboard()
    {
        view.endEditing(true)
    }
    
    @objc func nothing(){
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let topOffset = CGPoint(x: 0, y: -3)
        self.scrollView.setContentOffset(topOffset, animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 250, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        textField.resignFirstResponder()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 250, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
        
    }
        
    

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let bottomOffset = CGPoint(x:0, y:self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom)
        self.scrollView.setContentOffset(bottomOffset, animated: true)
     
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 250, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
      
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 250, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }


}
