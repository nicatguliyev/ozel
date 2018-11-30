//
//  YoutubeViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/25/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class YoutubeViewController: UIViewController {

    @IBOutlet weak var youtubeView: UIWebView!
    var videoUrlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(videoUrlString)
        
        let url = URL(string: videoUrlString)
        let request = URLRequest(url: url!)
        
        youtubeView.loadRequest(request)

        // Do any additional setup after loading the view.
    }

}
