//
//  PhotoDetailViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/25/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImage

        // Do any additional setup after loading the view.
    }

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    

    @IBAction func closePhoto(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
