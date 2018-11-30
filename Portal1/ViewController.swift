//
//  ViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/2/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "navTitle.png")
        let imageView = UIImageView(image:logo)
        
        /* let bannerWidth = navController?.navigationBar.frame.size.width
         let bannerHeight = navController?.navigationBar.frame.size.height
         
         let bannerX = bannerWidth! / 2 - (logo?.size.width)! / 2 - 40
         let bannerY = bannerHeight! / 2 - (logo?.size.height)! / 2 - 10
         
         imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth!, height: bannerHeight!) */
        
        imageView.frame = CGRect(x:0, y:0, width: 34, height: 34)
        
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        
        let leftButton = UIButton(type: UIButtonType.custom)
        leftButton.setImage(UIImage(named: "menIcon.png"), for: UIControlState.normal)
        leftButton.addTarget(self, action: #selector(callMethod), for: UIControlEvents.touchUpInside)
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: leftButton)
       // self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.leftBarButtonItem = barButton
        
        let rightBtn = UIButton(type: UIButtonType.custom)
        rightBtn.setImage(UIImage(named: "mecon.png"), for: UIControlState.normal)
        rightBtn.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let btn = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = btn
        
       
    }
    
    @objc func callMethod(){
        
    }
    
    @objc func nothing(){
        
    }




}

