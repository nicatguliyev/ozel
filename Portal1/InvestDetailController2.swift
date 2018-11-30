//
//  InvestDetailController2.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/22/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

class InvestDetailController2: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var webHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadHTMLString("<html><body><h2>Helloks csdc  sd;jc sd jsd c sdj sjd  sbfwe fj f;wjef wef  wefj wef w ef;jwef wef w efowef wef w efow ef we f;wjke fwef jw ef wef w e fkwefj wef we fwjef j wef wef  wefjwe f wef wekfwjefjwefwef  wefwjbef ef  weofbwejf wef bwef we fwjefw ef  weofbwe f we foief  wef wefoiwef  wefowiefw ef f weofiw ef f wefoiwef wekfwef wef weofw ef we foiwef w ef weof wef w ef[wiefw ef  wefoiwef wef weifwepfkjwefpowef w ef wepfw ef w efwepofnwkefwef w ef wepfnweof  wef w oefwpiefwe f  fw efoweofwoief wef w efpwefnwe f  wepfnw efw ef wpefw ef  we fwpefkwe f f wepfwef wef  fpwe[fnwkef we f wepfowe fwef  wefpwefpwef weof wepfowefw efpweofnw ef wepfw ef  wefpow ef  wefpwkef w ef w]epfw ef  f w]epfw ef !</h2></body></html>", baseURL: nil)
        
        // print(UIScreen.main.bounds.width)
         print(webView.scrollView.contentSize.height)
        // print(webView.frame.size.height)
        
         webView.scrollView.isScrollEnabled = false
        
        //webHeight.constant = webView.scrollView.contentSize.height
        
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
       // print(webView.scrollView.contentSize.height)
        webHeight.constant = webView.scrollView.contentSize.height
    }


}
