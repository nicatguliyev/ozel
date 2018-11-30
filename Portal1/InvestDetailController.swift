//
//  InvestDetailController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/9/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

struct InvestDetailModel: Decodable {
    let data: InvestDetailDataModel
}

struct InvestDetailDataModel: Decodable{
    let id: Int
    let title: String
    let body: String
    let image: String
    let gallery: [String]
}

class InvestDetailController: UIViewController, UIScrollViewDelegate, UIWebViewDelegate {
    
    
    var dataModel: InvestDetailDataModel?
    @IBOutlet weak var pageControlWidth: NSLayoutConstraint!
    var galleryCount = 0
    
    var leftButton  = UIButton()
    var rightButton = UIButton()
    var slideButtonList = [UIButton]()
    var slideImageList = [UIImageView]()
    var slideIndicatorList = [UIActivityIndicatorView]()
    var staticImages = ["slide1.jpg", "slide2.jpg"]
    var detailImageUrl = ""
    var webviewContent = ""
    var selectedSlideImage: UIImage?
    var detailId = ""

    @IBOutlet weak var investDetailImg: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var slideScroll: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageControlParentView: UIView!
    @IBOutlet weak var splashscreen: UIView!

    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    @IBOutlet weak var reloadView: UIView!
    @IBOutlet weak var splashIndicator: UIActivityIndicatorView!
    @IBOutlet weak var splashHeight: NSLayoutConstraint!
    @IBOutlet weak var splashScreen: UIView!
    
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(existDetailController), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)
        
        
        investDetailImg.layer.cornerRadius = 10
        investDetailImg.layer.masksToBounds = true
        
        getData()
        
        pageControlParentView.bringSubview(toFront: pageControl)
        
        self.webView.scrollView.isScrollEnabled = false
        
        self.view.bringSubview(toFront: splashScreen)
        splashHeight.constant = UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.size.height)!
        
        pageControl.layer.cornerRadius = 10
        
        
        let reloadGesture = UITapGestureRecognizer(target: self, action: #selector(reloadTapped))
        reloadView.addGestureRecognizer(reloadGesture)
        reloadView.isUserInteractionEnabled = true

    }
    
    @objc func reloadTapped(){
        getData()
    }
    
    @objc func existDetailController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func nothing(){
        
    }
    
    func getData() {
        
        splashScreen.isHidden = false
        reloadView.isHidden = true
        splashIndicator.isHidden = false
        
        let urlString = "http://142.93.186.89/api/v1/content/detail/" + detailId
        
        
        guard let url = URL(string: urlString)
            else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            if(err == nil){
            
            guard let data = data else { return }
            
            
            do{
                let content = try JSONDecoder().decode(InvestDetailModel.self, from: data)
                
                self.dataModel = content.data
                self.galleryCount = content.data.gallery.count
                self.detailImageUrl = content.data.image
                self.webviewContent = content.data.body
                
            }
                
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
        
                
                DispatchQueue.main.async {
                    
                    self.detailTitle.text = self.dataModel?.title
                    
                    
                    let screenWidth = UIScreen.main.bounds.width
                    self.pageControlWidth.constant = CGFloat((self.dataModel?.gallery.count)! * 20)
                    self.pageControl.numberOfPages = (self.dataModel?.gallery.count)!
                    
                    for index in 0..<self.galleryCount{
                        
                         var frame = CGRect(x:0, y:0, width:0, height: 0)
                        
                        frame.origin.x = screenWidth * CGFloat(index)
                        frame.origin.y = 0
                        frame.size.height = 150
                        frame.size.width = screenWidth
                        
                        
                        let image = UIImageView(frame: frame)
                        image.tag  = index
                        image.backgroundColor = UIColor.gray
                        self.slideScroll.addSubview(image)
                        self.slideImageList.append(image)
                        image.contentMode = .scaleAspectFill
                        
                        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(self.slideClicked(sender:)))
                        image.addGestureRecognizer(imageGesture)
                        image.isUserInteractionEnabled = true
                        
                        
                        var frame2 = CGRect(x:0, y:0, width:0, height: 0)
                        frame2.size.height = 30
                        frame2.size.width = 30
                        
                        
                        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
                        
                        activityIndicator.frame = frame2
                        activityIndicator.center.x = screenWidth * CGFloat(index + 1) - screenWidth/2
                        activityIndicator.center.y = 75
                        activityIndicator.startAnimating()
                        self.slideScroll.addSubview(activityIndicator)
                        self.slideIndicatorList.append(activityIndicator)
                        
                    
                    
                }
                  self.webView.loadHTMLString(self.webviewContent, baseURL: nil)
                 self.slideScroll.contentSize = CGSize(width: (screenWidth * CGFloat(self.galleryCount)), height: self.slideScroll.frame.size.height)
                self.splashScreen.isHidden = true
                self.loadImages()
                self.loadImageDetail()
            }
                
            }
            
            else {
                
                if let error = err as? NSError
                {
                    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorCannotConnectToHost{
                        DispatchQueue.main.async {
                            
                            self.splashScreen.isHidden = false
                            self.reloadView.isHidden = false
                            self.splashIndicator.isHidden = true
                            //self.investTable.isHidden = false
                            
                        }
                    }
                }
            }
            
            }.resume()
        
    }
    
    @objc func slideClicked(sender: UITapGestureRecognizer)
        
    {
    
    self.selectedSlideImage = self.slideImageList[(sender.view?.tag)!].image
        
      performSegue(withIdentifier: "PhotoDetail", sender: self)
        
    }
        
        
    
    func loadImages() {
        
        var imageUrl = ""
        
        if(galleryCount != 0)
        
        {
            
                
            for i in 0..<galleryCount{
                    
                    imageUrl = (dataModel?.gallery[i])!
                    
                     let url = URL(string: imageUrl)
                    
                    
                    URLSession.shared.dataTask(with: url!){(data, response, err) in
                        
                        if let content = data {
                            
                            DispatchQueue.main.async {
                                if(UIImage(data: content) != nil)
                                {
                                    self.slideImageList[i].image = UIImage(data: content)
                                }
                                
                                else
                                {
                                    self.slideImageList[i].image = UIImage(named: self.staticImages[i])
                                }
                                
                                self.slideIndicatorList[i].stopAnimating()
                            }
                            
                        }
                        
                        }.resume()
                    
                    
                }
            
        }
    
    }
    
    func loadImageDetail() {
        let url = URL(string: detailImageUrl)
        
        
        URLSession.shared.dataTask(with: url!){(data, response, err) in
            
            if let content = data {
                
                DispatchQueue.main.async {
                    if(UIImage(data: content) != nil)
                    {
                        self.investDetailImg.image = UIImage(data: content)
                        
                    }
                        
                    else
                    {
                        print("Sekiller Nillldir")
                        self.investDetailImg.image = UIImage(named: "slide1.jpg")
                    }
                    self.imageIndicator.isHidden = true
                }
                
            }
            
            }.resume()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView == slideScroll)
        {
            print("TATATATA")
            let pageNumber = slideScroll.contentOffset.x / scrollView.frame.size.width
            pageControl.currentPage = Int(pageNumber)
            print(Int(pageNumber))
        }
        
       
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webViewHeight.constant = webView.scrollView.contentSize.height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoDetail"
        {
            let destinationVC = segue.destination as! PhotoDetailViewController
            
            destinationVC.selectedImage = self.selectedSlideImage
            
        }
    }
    
}
