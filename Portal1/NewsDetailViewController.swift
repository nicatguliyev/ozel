//
//  NewsDetailViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/7/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit


struct NewsdetailModel: Decodable {
    let id: Int
    let title: String
    let body: String
}


class NewsDetailViewController: UIViewController, UIWebViewDelegate {
    
    var leftButton = UIButton()
    var rightButton = UIButton()
    var selectedNew:  SlideNewsDataModel?
    var selectedPostNew: PostNewsDataModel?
    var completedTask1 = false
    var completedTask2 = false
    var detailModel: NewsdetailModel?
    var newsType = ""
    var urlString = ""
    var detailString = ""


    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDetailImg: UIImageView!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(exitPage), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)

        
        
        newsDetailImg.layer.cornerRadius = 10
        newsDetailImg.clipsToBounds = true
        
        if(newsType == "Slide")
        {
            urlString = selectedNew!.image
            self.newsTitle.text = selectedNew!.title
            self.newsDate.text = selectedNew!.created_at
        }
        
        else
        {
            urlString = selectedPostNew!.image
            self.newsTitle.text = selectedPostNew!.title
            self.newsDate.text = selectedPostNew!.created_at
            
          //  urlString = selectedNew!.image
          //  self.newsTitle.text = selectedNew!.title
          //  self.newsDate.text = selectedNew!.created_at
        }
        
        self.webView.scrollView.isScrollEnabled = false
        
      
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url){(data, response, err) in
            
            guard let data = data else {return}
            
            if err == nil {
                DispatchQueue.main.async {
                    self.newsDetailImg.image = UIImage(data: data)
                    
                 //   let imgHeight = CGFloat((UIImage(data: data)?.size.height)!) * CGFloat((UIImage(data: data)?.scale)!)
                //    print("HIHI\(imgHeight)")
                //    self.imageHeight.constant = imgHeight
                    
                    self.completedTask1 = true
                    print(self.completedTask1)
                }
            }
            }.resume()
        
        
        if(newsType == "Slide"){
        detailString = "http://142.93.186.89/api/v1/posts/show/" + "\(selectedNew!.id)"
        }
        
        else
        {
            detailString = "http://142.93.186.89/api/v1/posts/show/" + "\(selectedPostNew!.id)"
        }
        
        guard let url2 = URL(string: detailString) else {return}
        
        URLSession.shared.dataTask(with: url2) {(data, response, err) in
            
            guard  let data = data else {return}
            
            
            do{
                self.detailModel = try JSONDecoder().decode(NewsdetailModel.self, from: data)
                
            }
                
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
            
            if err == nil {
                
                DispatchQueue.main.async {
                    self.webView.loadHTMLString(self.detailModel!.body, baseURL: nil)
                    self.completedTask2 = true
                
                }
                
            }
            
        }.resume()

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webViewHeight.constant = webView.scrollView.contentSize.height
        indicator.isHidden = true
    }

    
    @objc func exitPage(){
        self.navigationController?.popViewController(animated: true)
      
    }
    
    @objc func nothing(){
        
    }


}
