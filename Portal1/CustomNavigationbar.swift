//
//  CustomNavigationbar.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/14/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import Foundation

class  CustomNavigationBar {
    
    func createButtonsAndTittle(viewController: UIViewController, leftButton: UIButton, rightBtn: UIButton, type: Int){
        
        if(type == 1)
        {
            
             leftButton.setImage(UIImage(named: "menIcon.png"), for: UIControlState.normal)
        }
        else
        {
            leftButton.setImage(UIImage(named: "backIcon.png"), for: UIControlState.normal)
        }
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 20)
        let barButton = UIBarButtonItem(customView: leftButton)
        viewController.navigationItem.leftBarButtonItem = barButton
        
        let logo = UIImage(named: "navTitle.png")
        let imageView = UIImageView(image:logo)
        
        
        imageView.frame = CGRect(x:0, y:0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: viewController.view.frame.size.width - 132).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        viewController.navigationItem.titleView = imageView
        
        
        
        rightBtn.setImage(UIImage(named: "mecon.png"), for: UIControlState.normal)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let btn = UIBarButtonItem(customView: rightBtn)
        viewController.navigationItem.rightBarButtonItem = btn
        
        
    }
    
}
