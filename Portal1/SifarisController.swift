//
//  SifarisController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/10/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

struct  sifarisModel: Decodable {
    let id: Int
    let title: String
    let body: String
    let images: [String]
}

class SifarisController: UIViewController, UIScrollViewDelegate, UIWebViewDelegate {

    @IBOutlet weak var sifarisView: UIView!
    @IBOutlet weak var slideScroll: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var slideParentView: UIView!
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var splashScreen: UIView!
    @IBOutlet weak var splashIndicator: UIActivityIndicatorView!
    @IBOutlet weak var splashScreenHeight: NSLayoutConstraint!
    @IBOutlet weak var slideHeight: NSLayoutConstraint!
    @IBOutlet weak var pageControlWidth: NSLayoutConstraint!
    @IBOutlet weak var webviewIndicator: UIActivityIndicatorView!
    @IBOutlet weak var reloadView: UIView!
    
    var leftButton = UIButton()
    var rightButton = UIButton()
    var selectedMenu: MenuModel?
    var selectedModel: HerracDetailDataModel2?
    var slideImages = [String]()
    var slideIndicatorList = [UIActivityIndicatorView]()
    var slideButtonList = [UIButton]()
    var slideImageList = [UIImageView]()
    var staticImages = ["slide1.jpg", "slide2.jpg", "slide3.jpg"]
    var webviewContent = ""
    var selectedSlideImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sifarisView.layer.cornerRadius = 10
        
        let navBarColor = UIColor(red: 13/255, green: 140/255 , blue: 207/255, alpha: 1);
        let navBar = self.navigationController?.navigationBar
        
        navBar?.barTintColor = navBarColor
        navBar?.isTranslucent = false
        
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(exitKicikDovletController), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)
        
        titleLable.text = selectedModel?.title
        pageControl.layer.cornerRadius = 10
        
        self.view.bringSubview(toFront: splashScreen)
        splashScreenHeight.constant = UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.size.height)!
        
        webView.scrollView.isScrollEnabled = false
        
        
        let reloadGesture = UITapGestureRecognizer(target: self, action: #selector(reloadTapped))
        reloadView.addGestureRecognizer(reloadGesture)
        reloadView.isUserInteractionEnabled = true
        
        
        getData()
        
        
    }
    
    @objc func reloadTapped(){
        getData()
    }
    
    @objc func exitKicikDovletController(){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func nothing(){
        
    }
    
    
    func getData() {
        
        var urlString = ""
        self.reloadView.isHidden = true
        self.splashIndicator.isHidden = false
        
        if let id = selectedModel?.id {
            urlString = "http://142.93.186.89/api/v1/auctions/show/\(id)"
        }
        
            
            guard let url = URL(string: urlString) else {return}
            
            URLSession.shared.dataTask(with: url){(data, response, err) in
                
                if( err == nil){
                
                guard let content = data else {return}
                
                do{
                    let model = try JSONDecoder().decode(sifarisModel.self, from: content)
                  
                    self.webviewContent = model.body
                    
                    for i in 0..<model.images.count{
                        self.slideImages.append(model.images[i])
                    }
                }
                    
                catch let jsonError {
                    print("jsonError")
                }
                
                    DispatchQueue.main.async {
                        
                        
                        self.webView.loadHTMLString(self.webviewContent, baseURL: nil)
                        self.pageControlWidth.constant = CGFloat(self.slideImages.count * 20)
                        for index in 0..<self.slideImages.count{
                        
                        let screenwidth = UIScreen.main.bounds.width
                        
                        var frame = CGRect(x:0, y:0, width:0, height: 0)
                        frame.origin.x = screenwidth * CGFloat(index)
                        frame.origin.y = 0
                        frame.size.height = 150
                        frame.size.width = screenwidth
                        
                        
                       /* let btn = UIButton(frame: frame)
                        btn.tag = index
                        btn.addTarget(self, action: #selector(self.slideClicked), for: .touchUpInside)
                        btn.backgroundColor = UIColor.gray
                        self.slideScroll.addSubview(btn)
                        self.slideButtonList.append(btn)  */
                            
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
                        activityIndicator.center.x = screenwidth * CGFloat(index + 1) - screenwidth/2
                        activityIndicator.center.y = 75
                        activityIndicator.startAnimating()
                        self.slideScroll.addSubview(activityIndicator)
                        self.slideIndicatorList.append(activityIndicator)
                            
                        }
                        
                        self.splashScreen.isHidden = true
                        self.slideScroll.contentSize = CGSize(width: (UIScreen.main.bounds.width * CGFloat(self.slideImages.count)), height: self.slideScroll.frame.size.height)
                        self.loadSlideImages()
                        
                        
                        if(self.slideImages.count == 0)
                        {
                            self.slideHeight.constant = 0
                        }
                        
                    }
                }
                
                else
                {
                    if let error = err as? NSError
                    {
                        if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorCannotConnectToHost {
                            DispatchQueue.main.async {
                                
                                self.splashScreen.isHidden = false
                                self.reloadView.isHidden = false
                                self.splashIndicator.isHidden = true
                                
                            }
                        }
                        
                    }
                }
                    
             //   }
            }.resume()
        
    }
    
    
    func loadSlideImages() {
        
        var imageUrlString = ""
        
        for i in 0..<slideImages.count{
            
            imageUrlString = slideImages[i]
            
            guard let url = URL(string: imageUrlString) else {return}
            
            URLSession.shared.dataTask(with: url){(data, response, err) in
                
            guard let content = data else {return}
            
                if(err  == nil){
                    let image = UIImage(data: content)
                    DispatchQueue.main.async {
                        if(image != nil){
                         //self.slideButtonList[i].setBackgroundImage(image, for: .normal)
                            self.slideImageList[i].image = image
                        }
                        else
                        {
                           // self.slideButtonList[i].setBackgroundImage(UIImage(named: self.staticImages[i]), for: .normal)
                            self.slideImageList[i].image = UIImage(named: self.staticImages[i])
                        }
                        self.slideIndicatorList[i].stopAnimating()
                    }
                }
                
            }.resume()
            
            
        }
        
    }
    
    @objc func slideClicked(sender: UITapGestureRecognizer)
        
    {
        
        self.selectedSlideImage = self.slideImageList[(sender.view?.tag)!].image
        
        performSegue(withIdentifier: "PhotoDetail", sender: self)
        
    }
    
    
    
    @IBAction func sifarisPressed(_ sender: Any) {
       
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView == slideScroll)
        {
                let pageNumber = slideScroll.contentOffset.x / scrollView.frame.size.width
                pageControl.currentPage = Int(pageNumber)
    
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webviewIndicator.isHidden = true
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
