//
//  SegueToInvestController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/8/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class SegueToInvestController: UIStoryboardSegue {
    
    override func perform() {
        let src: UIViewController = self.source
        let dst: UIViewController = self.destination
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.25
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        src.navigationController!.view.layer.add(transition, forKey: kCATransition)
        src.present(dst, animated: false, completion: nil)
    }

}
