//
//  NewsViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/2/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit


struct SlideNewsModel: Decodable {
    let data: [SlideNewsDataModel]

}

struct SlideNewsDataModel: Decodable {
    let id: Int
    let title: String
    let image: String
    let created_at: String
}

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    var menuVisible = false
    var menuWidth = 0
    var screenWidth: CGFloat = 0
    @IBOutlet weak var menuWidthConstarint: NSLayoutConstraint!
    @IBOutlet weak var newViewLeading: NSLayoutConstraint!
    @IBOutlet weak var newViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var herracHeightConst: NSLayoutConstraint!
    @IBOutlet weak var investTableHeightConst: NSLayoutConstraint!
    @IBOutlet weak var muesseTableHeightConst: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var investView: UIView!
    @IBOutlet weak var herracView: UIView!
    @IBOutlet weak var muesseView: UIView!
    @IBOutlet weak var inestTable: UITableView!
    @IBOutlet weak var muesseTable: UITableView!
    @IBOutlet weak var hiddenHerracView: UIView!
    @IBOutlet weak var ozellesdirmeView: UIView!
    @IBOutlet weak var musadireView: UIView!
    @IBOutlet weak var ozelLbl: UILabel!
    @IBOutlet weak var downArrow1: UIImageView!
    @IBOutlet weak var downArrow2: UIImageView!
    @IBOutlet weak var downArrow3: UIImageView!
    @IBOutlet weak var downArrow4: UIImageView!
    @IBOutlet weak var bildirisView: UIView!
    @IBOutlet weak var idareEtmeView: UIView!
    @IBOutlet weak var slideScroll: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var pageControlParentView: UIView!
    @IBOutlet weak var sehmdarView: UIView!
    @IBOutlet weak var kicikDovletView: UIView!
    @IBOutlet weak var menbeView: UIView!
    @IBOutlet weak var downArrow5: UIImageView!
    @IBOutlet weak var neqliyatView: UIView!
    @IBOutlet weak var menuScrollView: UIScrollView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var menbeTableConst: NSLayoutConstraint!
    @IBOutlet weak var yardimTableConst: NSLayoutConstraint!
    @IBOutlet weak var yardimView: UIView!
    @IBOutlet weak var pageControlWidth: NSLayoutConstraint!
    
    @IBOutlet weak var yardimTable: UITableView!
    @IBOutlet weak var menbeTable: UITableView!
    
    @IBOutlet weak var sehmdarLbl: UILabel!
    @IBOutlet weak var kicikDovletLbl: UILabel!
    @IBOutlet weak var musadireLbl: UILabel!
    @IBOutlet weak var elanLbl: UILabel!
    @IBOutlet weak var neticeLbl: UILabel!
    @IBOutlet weak var neqliyyatLbl: UILabel!
    @IBOutlet weak var bildirisLbl: UILabel!
    @IBOutlet weak var idareLbl: UILabel!
    @IBOutlet weak var slideTtile: UILabel!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var mainIndicator: UIActivityIndicatorView!
    @IBOutlet weak var splashParentView: UIView!
    
    @IBOutlet weak var splashView: UIView!
    @IBOutlet weak var bottomIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var bottomConstrainr: NSLayoutConstraint!
    var selectedMenu: MenuModel?
    var selectedSlide: SlideNewsDataModel?
    var selectedPostNew: PostNewsDataModel?

    
    var mainMenus = [MenuModel]()
    var investMenus = [MenuModel]()
    var muesseMenus = [MenuModel]()
    var herracMenus = [MenuModel]()
    
    var slideNews = [SlideNewsDataModel]()
    var postNews = [PostNewsDataModel]()
    var slideIndicatorList = [UIActivityIndicatorView]()
    var slideButtonList = [UIButton]()
    var slideImageList = [UIImageView]()
    
    var tableConstArray = [NSLayoutConstraint]()
    var viewArray = [UIView]()
    var imagesArray = [UIImageView]()
    
    var menbeArray = ["Şəkillər və Videoçarxlar", "Xəbərlər"]
    var yardimArray = ["Bizimlə əlaqə", "Sual-cavab"]
    var leftButton = UIButton()
    var rightButton = UIButton()
    var images: [String] = ["slide1.jpg", "slide2.jpg", "slide3.jpg"]
    var newImage = [String]()
    var parameterToSehmdar = ""
    var frame = CGRect()
    var newsType = ""
    var selectedPostnew: SlideNewsDataModel?
    var reloadCompleted = false
    var reachedLastPage = false
    var currentPage = 1
    var imageCash = [Int: UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      pageControl.layer.cornerRadius = 10
        
      let navBarColor = UIColor(red: 13/255, green: 140/255 , blue: 207/255, alpha: 1);
      let navBar = self.navigationController?.navigationBar
        
      navBar?.barTintColor = navBarColor
      navBar?.isTranslucent = false
        

        let screenSize = UIScreen.main.bounds
        screenWidth =  screenSize.width
    
        menuWidth = Int(-(screenWidth - 40))
        frame = CGRect(x:0, y:0, width:0, height: 0)
        
        
        getSlideNews()
        getPostNews(page: currentPage)
        
        collectView.isHidden = true
        

        
        ozelLbl.text = mainMenus[1].title
        bildirisLbl.text = mainMenus[3].title
        idareLbl.text = mainMenus[4].title
        sehmdarLbl.text = herracMenus[0].title
        kicikDovletLbl.text = herracMenus[2].title
        neqliyyatLbl.text = herracMenus[3].title
        musadireLbl.text = herracMenus[4].title
        
        
        menuWidthConstarint.constant = -(CGFloat(menuWidth))
        menuLeadingConstraint.constant = CGFloat(menuWidth)
        
        
        
        investView.layer.cornerRadius = 10
        investView.clipsToBounds = true
        herracView.layer.cornerRadius = 10
        herracView.clipsToBounds = true
        muesseView.layer.cornerRadius = 10
        muesseView.clipsToBounds = true
        ozellesdirmeView.layer.cornerRadius = 10
        ozellesdirmeView.clipsToBounds = true
        bildirisView.layer.cornerRadius = 10
        bildirisView.clipsToBounds = true
        idareEtmeView.layer.cornerRadius = 10
        idareEtmeView.clipsToBounds = true
        yardimView.layer.cornerRadius = 10
        yardimView.clipsToBounds = true
        menbeView.layer.cornerRadius = 10
        menbeView.clipsToBounds = true
        
        tableConstArray = [investTableHeightConst, herracHeightConst, yardimTableConst, menbeTableConst]
        viewArray = [investView, herracView, yardimView, menbeView]
        imagesArray = [downArrow1, downArrow2, downArrow5, downArrow4]
        
        
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        leftButton.isHidden = true
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(callMethod), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 1)
        
        self.splashParentView.bringSubview(toFront: splashView)
        
        
        collectView.isScrollEnabled = false
        //collectionHeight.constant = CGFloat(newsNames.count * 300 + 40)
        print(herracMenus)
        
        pageControlParentView.bringSubview(toFront: pageControl)
    
        slideScroll.delegate = self
        
        
        herracHeightConst.constant  = 0
        hiddenHerracView.clipsToBounds = true
        
        inestTable.isScrollEnabled = false
        muesseTable.isScrollEnabled = false
        yardimTable.isScrollEnabled = false
        menbeTable.isScrollEnabled = false

        let investTapGesture = UITapGestureRecognizer(target: self, action: #selector(investTapped))
        investView.addGestureRecognizer(investTapGesture)
        investView.isUserInteractionEnabled = true
        
        let muessetapGesture = UITapGestureRecognizer(target: self, action: #selector(muesseTapped))
        muesseView.addGestureRecognizer(muessetapGesture)
        muesseView.isUserInteractionEnabled = true
        
        let herracTapGesture = UITapGestureRecognizer(target: self, action: #selector(herracTapped))
        herracView.addGestureRecognizer(herracTapGesture)
        herracView.isUserInteractionEnabled = true
        
        let yardimTapGesture = UITapGestureRecognizer(target: self, action: #selector(yardimTapped))
        yardimView.addGestureRecognizer(yardimTapGesture)
        yardimView.isUserInteractionEnabled = true
        
        let menbeTapGesture = UITapGestureRecognizer(target: self, action: #selector(menbeTapped))
        menbeView.addGestureRecognizer(menbeTapGesture)
        menbeView.isUserInteractionEnabled = true
        
        let sehmdarTapGesture = UITapGestureRecognizer(target: self, action: #selector(sehmdarTapped))
        sehmdarView.addGestureRecognizer(sehmdarTapGesture)
        sehmdarView.isUserInteractionEnabled = true
        
        let neqliyyatTapGesture = UITapGestureRecognizer(target: self, action: #selector(neqliyyatTapped))
        neqliyatView.addGestureRecognizer(neqliyyatTapGesture)
        neqliyatView.isUserInteractionEnabled = true
        
        let musadireTapGesture = UITapGestureRecognizer(target: self, action: #selector(musadireTapped))
        musadireView.addGestureRecognizer(musadireTapGesture)
        musadireView.isUserInteractionEnabled = true
        
        let ozelTapGesture = UITapGestureRecognizer(target: self, action: #selector(ozelTapped))
        ozellesdirmeView.addGestureRecognizer(ozelTapGesture)
        ozellesdirmeView.isUserInteractionEnabled = true
        
        let bildirisTapGesture = UITapGestureRecognizer(target: self, action: #selector(bildirisTapped))
        bildirisView.addGestureRecognizer(bildirisTapGesture)
        bildirisView.isUserInteractionEnabled = true
        
        let idareTapGesture = UITapGestureRecognizer(target: self, action: #selector(idareTapped))
        idareEtmeView.addGestureRecognizer(idareTapGesture)
        idareEtmeView.isUserInteractionEnabled = true
        
        let kicikTapGesture = UITapGestureRecognizer(target: self, action: #selector(kicikTapped))
        kicikDovletView.addGestureRecognizer(kicikTapGesture)
        kicikDovletView.isUserInteractionEnabled = true
        
        
    }
    
    @objc func slideClicked(sender: UITapGestureRecognizer){
        selectedSlide = slideNews[(sender.view?.tag)!]     // tiklanan buttona gore secilmis slide - in indexini goturur
       self.newsType = "Slide"
       performSegue(withIdentifier: "SegueToNewsDetail", sender: self)
       
    }
    
    @objc func nothing(){
        
    }
    
    @objc func investTapped(){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.closeOtherTables(view: self.investView)
            if(self.investTableHeightConst.constant == 0)
            {
                self.investTableHeightConst.constant = CGFloat(self.investMenus.count * 50)
                self.downArrow1.transform = CGAffineTransform(rotationAngle:  CGFloat.pi / 2)
                self.view.layoutIfNeeded()
            }
            
            else{
                self.investTableHeightConst.constant = 0
                 self.downArrow1.transform = CGAffineTransform(rotationAngle: 0)
                self.view.layoutIfNeeded()
            }
       
        })
    }
    
    
    @objc func callMethod(){
        if(menuVisible)
        {
            leftButton.setImage(UIImage(named: "menIcon.png"), for: UIControlState.normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.menuVisible = false
                self.menuLeadingConstraint.constant = CGFloat(self.menuWidth)
                self.newViewLeading.constant = 0
                self.newViewTrailing.constant = 0
                self.view.layoutIfNeeded()
            })
        }
        else
        {
            leftButton.setImage(UIImage(named: "backIcon.png"), for: UIControlState.normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.newViewTrailing.constant = -CGFloat(self.menuWidth)
                self.menuVisible = true
                self.menuLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func muesseTapped(){
        UIView.animate(withDuration: 0.4, animations: {
            if(self.muesseTableHeightConst.constant == 0)
            {
                self.muesseTableHeightConst.constant = CGFloat(self.muesseMenus.count * 50)
                self.herracHeightConst.constant = self.herracHeightConst.constant + CGFloat(self.muesseMenus.count * 50)
                self.downArrow3.transform = CGAffineTransform(rotationAngle:  CGFloat.pi / 2)
                self.view.layoutIfNeeded()
            }
                
            else{
                self.muesseTableHeightConst.constant = 0
                self.herracHeightConst.constant = self.herracHeightConst.constant - CGFloat(self.muesseMenus.count * 50)
                self.downArrow3.transform = CGAffineTransform(rotationAngle:  0)
                self.view.layoutIfNeeded()
            }
            
        })
    }
    
    @objc func herracTapped(){
        UIView.animate(withDuration: 0.4, animations: {
            self.closeOtherTables(view: self.herracView)
            if(self.herracHeightConst.constant == 0)
            {
                if(self.screenWidth < 360)
                {
                    self.herracHeightConst.constant = 464
                    
                }
                else
                {
                    self.herracHeightConst.constant = 420
                    
                }
                self.downArrow2.transform = CGAffineTransform(rotationAngle:  CGFloat.pi / 2)
                self.investTableHeightConst.constant = 0
                self.view.layoutIfNeeded()
            }
                
            else{
                self.herracHeightConst.constant = 0
                self.downArrow3.transform = CGAffineTransform(rotationAngle:  0)
                self.muesseTableHeightConst.constant = 0
                self.downArrow2.transform = CGAffineTransform(rotationAngle: 0)
                self.view.layoutIfNeeded()
            }
            
        })
    }
    
    
    @objc func menbeTapped(){
        
        if(menbeTableConst.constant == 0)
        {
            closeOtherTables(view: menbeView)
            
            if(UIScreen.main.bounds.height < 570)
            {
            let topOffset = CGPoint(x: 0, y: 80)
            self.menuScrollView.setContentOffset(topOffset, animated: true)
            }
            
            UIView.animate(withDuration: 0.4, animations: {
                
                self.menbeTableConst.constant = 100
                self.downArrow4.transform = CGAffineTransform(rotationAngle:  CGFloat.pi / 2)
                self.view.layoutIfNeeded()
            })
           
        }
        else
        {
            UIView.animate(withDuration: 0.4, animations: {
                
                self.menbeTableConst.constant = 0
                self.downArrow4.transform = CGAffineTransform(rotationAngle: 0)
                self.view.layoutIfNeeded()
                
            })
        }
        
    }
    
    @objc func sehmdarTapped(){
      self.parameterToSehmdar = "FromNeqliyyat"
        closeAllMenus()
        self.selectedMenu = herracMenus[0]
        self.performSegue(withIdentifier: "segueToSehmdar", sender: self)
    }
    
    @objc func neqliyyatTapped(){
        self.parameterToSehmdar = "FromNeqliyyat"
        self.selectedMenu = herracMenus[3]
        closeAllMenus()
        self.performSegue(withIdentifier: "segueToSehmdar", sender: self)
    }
    
    @objc func musadireTapped(){
        self.parameterToSehmdar = "FromNeqliyyat"
        self.selectedMenu = herracMenus[4]
        closeAllMenus()
        self.performSegue(withIdentifier: "segueToSehmdar", sender: self)
    }
    
    
    @objc func ozelTapped(){
        closeAllMenus()
        self.selectedMenu = mainMenus[1]
        self.performSegue(withIdentifier: "segueToInvest", sender: self)

    }
    
    
    @objc func bildirisTapped(){
        closeAllMenus()
        self.selectedMenu = mainMenus[3]
        self.performSegue(withIdentifier: "segueToInvest", sender: self)
    }
    
    
    @objc func idareTapped(){
        closeAllMenus()
        self.selectedMenu = mainMenus[4]
        self.performSegue(withIdentifier: "segueToInvest", sender: self)
    }
    
    @objc func kicikTapped(){
        closeAllMenus()
        self.parameterToSehmdar = "FromKicik"
        self.selectedMenu = herracMenus[2]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            
          self.performSegue(withIdentifier: "segueToSehmdar", sender: self)
            
        })
    }
    
    
    
    @objc func yardimTapped(){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.closeOtherTables(view: self.yardimView)
            if(self.yardimTableConst.constant == 0)
            {
                self.yardimTableConst.constant = 100
                self.downArrow5.transform = CGAffineTransform(rotationAngle:  CGFloat.pi / 2)
                self.view.layoutIfNeeded()
                if(UIScreen.main.bounds.height < 570)
                {
                let topOffset = CGPoint(x: 0, y: 80)
                self.menuScrollView.setContentOffset(topOffset, animated: true)
            }
        }
                
            else{
                self.yardimTableConst.constant = 0
                self.downArrow5.transform = CGAffineTransform(rotationAngle:  0)
                self.view.layoutIfNeeded()
            }
            
        })
    }
    
    
    
    
    
    @IBAction func menuBtnClicked(_ sender: Any) {
        
        if(menuVisible)
        {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.menuVisible = false
                self.menuLeadingConstraint.constant = CGFloat(self.menuWidth)
                self.view.layoutIfNeeded()
            })
        }
        else
        {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.menuVisible = true
                self.newViewLeading.constant = 150
                self.menuLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if(tableView == inestTable)
        {
            return investMenus.count
        }
        
        else if(tableView == muesseTable){
            return muesseMenus.count
        }
        else
        {
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == inestTable)
        {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "investCell") as! InvestiyaTableViewCell
            
            cell1.investiyaListItem.text = investMenus[indexPath.row].title
            
            return cell1
        }
        else if(tableView == muesseTable)
        {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "muessiseCell") as! MuessiseTableViewCell
            
             cell2.muesseListItem.text = muesseMenus[indexPath.row].title
            return cell2
        }
        
        else if(tableView == yardimTable)
        {
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "yardimCell") as! YardimTableViewCell
            
            cell3.yardimLbl.text = yardimArray[indexPath.row]
            return cell3
        }
        
        else
        {
            let cell4 = tableView.dequeueReusableCell(withIdentifier: "menbeCell") as! YardimTableViewCell
            
            cell4.menbeLbl.text = self.menbeArray[indexPath.row]
            
            return cell4
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        closeAllMenus()
        
        if(tableView == menbeTable)
        {
            if(indexPath.row == 0)
            {
                performSegue(withIdentifier: "segueToPhotos", sender: self)
            }
            if(indexPath.row == 1)
            {
                performSegue(withIdentifier: "segueToNews", sender: self)
            }
        }
        
        if(tableView == yardimTable)
        {
            if(indexPath.row == 0)
            {
                performSegue(withIdentifier: "SegueToElaqe", sender: self)
            }
            if(indexPath.row == 1)
            {
                performSegue(withIdentifier: "SegueToSualCavab", sender: self)
            }
        }
        
        if(tableView == muesseTable)
        {
              self.parameterToSehmdar = "FromKicik"
              self.selectedMenu = muesseMenus[indexPath.row]
              performSegue(withIdentifier: "segueToSehmdar", sender: self)
            
        }
        
        if(tableView == inestTable)
        {
            self.selectedMenu = investMenus[indexPath.row]
            performSegue(withIdentifier: "segueToInvest", sender: self)
        }
        
     
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView == slideScroll)
        {
        let pageNumber = slideScroll.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
            print(Int(pageNumber))
        slideTtile.text = self.slideNews[Int(pageNumber)].title
        }
        if(scrollView == mainScroll){

        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView == mainScroll){
            let  height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if distanceFromBottom < height {
            
                if(reloadCompleted == true)
                
                {
                    if(reachedLastPage == false)
                    {
                        self.bottomIndicator.isHidden = false
                        self.bottomConstrainr.constant = 10
                        self.getPostNews(page: currentPage)
                        reloadCompleted = false
                    }
                }
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Sagopa \(postNews.count)")
        return postNews.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCollectionViewCell
        
        cell.newsNameLbl.text = postNews[indexPath.row].title
        cell.newsImage.layer.cornerRadius = 10
        cell.newsImage.layer.masksToBounds = true
        cell.dateLbl.text = postNews[indexPath.row].created_at
        
        
        if(imageCash[indexPath.row] == nil){
        if(postNews.count != 0){
            
            let urlString = URL(string: newImage[indexPath.row])
            
            URLSession.shared.dataTask(with: urlString!){(data, response, err) in
                
                if let content = data {
                    
                    DispatchQueue.main.async {
                        cell.newsImage.image = UIImage(data: content)
                        self.imageCash[indexPath.row] = UIImage(data: content)
                        cell.imageIndicator.isHidden = true
                        cell.newsImage.isHidden = false
                    }
                    
                }
                
                }.resume()
            
        }
            
        }
        else
        {
            cell.newsImage.image = imageCash[indexPath.row]
            cell.imageIndicator.isHidden = true
            cell.newsImage.isHidden = false
        }
        
        if(indexPath.row == newImage.count - 1)
        {
            print(cell.newsNameLbl.text)
        }
    
        
        cell.readmoreBtn.layer.borderWidth = 2
        cell.readmoreBtn.layer.borderColor = UIColor(red: 13/255, green: 140/255, blue: 207/255, alpha: 1).cgColor
        cell.readmoreBtn.layer.cornerRadius = 10
        cell.readmoreBtn.layer.masksToBounds = true
        
        cell.readmoreBtn.tag = indexPath.row
        cell.readmoreBtn.addTarget(self, action: #selector(goToNewsDetail), for: UIControlEvents.touchUpInside)
        
        cell.contentView.layer.cornerRadius = 4
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowRadius = 4.0
        cell.layer.cornerRadius = 10
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth =  screenSize.width
        return CGSize(width: screenWidth - CGFloat(32), height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        newsType = "Post"
        selectedPostNew = postNews[indexPath.row]
        performSegue(withIdentifier: "SegueToNewsDetail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(10, 0, 10, 0)
    }
    
    func closeMenuFromHerrac(){
    
        closeMenu()
        self.herracHeightConst.constant = 0
        self.downArrow3.transform = CGAffineTransform(rotationAngle:  0)
        self.muesseTableHeightConst.constant = 0
        self.downArrow2.transform = CGAffineTransform(rotationAngle: 0)
        self.view.layoutIfNeeded()
        
    }
    
    
    @objc func goToNewsDetail(sender: UIButton) {
        newsType = "Post"
        selectedPostNew = postNews[sender.tag]
        performSegue(withIdentifier: "SegueToNewsDetail", sender: self)
    }
    
    
    func closeMenu(){
        
        leftButton.setImage(UIImage(named: "menIcon.png"), for: UIControlState.normal)
        UIView.animate(withDuration: 0.3, animations: {
            self.menuVisible = false
            self.menuLeadingConstraint.constant = CGFloat(self.menuWidth)
            self.newViewLeading.constant = 0
            self.newViewTrailing.constant = 0
            self.view.layoutIfNeeded()
        })
        
    }
    
    func closeAllMenus(){
        
        var tableHeights = [self.investTableHeightConst, herracHeightConst, muesseTableHeightConst, menbeTableConst, yardimTableConst]
        var imagesArr = [downArrow1, downArrow2, downArrow3, downArrow4, downArrow5]
        
        for i in 0..<tableHeights.count{
            tableHeights[i]?.constant = 0
            imagesArr[i]?.transform = CGAffineTransform(rotationAngle: 0)
        }
        
        
        leftButton.setImage(UIImage(named: "menIcon.png"), for: UIControlState.normal)
        UIView.animate(withDuration: 0.3, animations: {
            self.menuVisible = false
            self.menuLeadingConstraint.constant = CGFloat(self.menuWidth)
            self.newViewLeading.constant = 0
            self.newViewTrailing.constant = 0
            self.view.layoutIfNeeded()
        })
        
    }
    
    func closeOtherTables(view: UIView) {
        var viewIndex = 0
        for _view in viewArray {
            
            if(view != _view)
            {
                viewIndex = viewIndex + 1
            }
            else
            {
                break
            }
        }
        
        for i in 0..<4 {
            
            if(i != viewIndex)
            {
                UIView.animate(withDuration: 0.4, animations: {
                    if(i == 1)
                    {
                        self.muesseTableHeightConst.constant = 0
                        self.downArrow3.transform = CGAffineTransform(rotationAngle: 0)
                        self.view.layoutIfNeeded()
                    }
                    self.tableConstArray[i].constant = 0
                    self.imagesArray[i].transform = CGAffineTransform(rotationAngle: 0)
                    self.view.layoutIfNeeded()
                })
                
                
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSehmdar"
        {
            let destinationVC = segue.destination as! SehmdarViewController
            destinationVC.selectedMenu = self.selectedMenu
            destinationVC.parameterFromOut = self.parameterToSehmdar

        }
        
        if segue.identifier == "segueToInvest"
        {
            let destinationVC = segue.destination as! InvestViewController
            
            destinationVC.selectedMenu = self.selectedMenu
        }
        
        if segue.identifier == "SegueToNewsDetail"
        {
            let destinationVc = segue.destination as! NewsDetailViewController
            destinationVc.newsType = self.newsType
            destinationVc.selectedNew = self.selectedSlide
            destinationVc.selectedPostNew = self.selectedPostNew
        }
    }
    
    
    
    // Slide xeberlerni almaq ucun
    
    func getSlideNews() {
        
        let urlString = "http://142.93.186.89/api/v1/posts/gallery"
        
        guard let url = URL(string: urlString)
            else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            guard let data = data else { return }

        
            do{
                let slideNews = try JSONDecoder().decode(SlideNewsModel.self, from: data)
                
                for i in 0..<slideNews.data.count{
                    let model = slideNews.data[i]
                    self.slideNews.append(model)
                }
          
            }
                
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
            
            if (err == nil)
            {
            
                DispatchQueue.main.async {
                    
                    let screenWidth = UIScreen.main.bounds.width
                    self.pageControlWidth.constant = CGFloat(self.slideNews.count * 20)
                    self.pageControl.numberOfPages = self.slideNews.count
                    self.slideTtile.text = self.slideNews[0].title
                    
                    for index in 0..<self.slideNews.count{
                        
                        self.frame.origin.x = screenWidth * CGFloat(index)
                        self.frame.origin.y = 0
                        self.frame.size.height = 150
                        self.frame.size.width = screenWidth
                        
                        
                        
                        let image = UIImageView(frame: self.frame)
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
                        self.splashView.isHidden = true
                        
                    }
                    
                    
                    self.slideScroll.contentSize = CGSize(width: (screenWidth * CGFloat(self.slideNews.count)), height: self.slideScroll.frame.size.height)
                }
                
               self.loadSlideImages()
            }
            
            }.resume()

        
    }
    
    // Sekilleri Yuklemek Ucun..
    
    func loadSlideImages(){
        
        for i in 0..<slideNews.count{
            
            let urlString = slideNews[i].image
            
            guard let url = URL(string: urlString) else {return}
            
            URLSession.shared.dataTask(with: url){(data, response, err) in
                
                guard let data = data else {return}
                
                if err == nil {
                    DispatchQueue.main.async {
                   
                        self.slideImageList[i].image = UIImage(data:data)
                    self.slideIndicatorList[i].stopAnimating()
                    self.leftButton.isHidden = false
                    }
                }
            }.resume()
            
        }
    }
    
    
    func getPostNews(page: Int) {
        let urlString = "http://142.93.186.89/api/v1/posts/index?page=" + "\(page)"
        
    
        guard let url = URL(string: urlString)
            else {return}
        
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            guard let data = data else { return }
            
            
            do{
                let slideNews = try JSONDecoder().decode(PostNewsModel.self, from: data)
                
                for i in 0..<slideNews.data.count{
                    let model = slideNews.data[i]
                    self.newImage.append(model.image)
                    self.postNews.append(model)
                    
                }
                
                if(slideNews.next_page_url != nil)
                {
                    self.currentPage = self.currentPage + 1
                }
                else
                {
                    self.reachedLastPage = true
                }
                
            }
                
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
            
            if (err == nil)
            {
                
                DispatchQueue.main.async {
                    self.mainIndicator.isHidden = true
                    self.collectView.isHidden = false
                    self.collectionHeight.constant = CGFloat(self.postNews.count * 300 + (self.postNews.count + 1) * 10)
                  //  self.collectionHeight.constant = CGFloat(self.postNews.count * 300)
                   // self.bottomIndicator.isHidden = true
                    self.reloadCompleted = true
                    self.bottomConstrainr.constant = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                         self.collectView.reloadData()
                        self.bottomIndicator.isHidden = true
                    })
                   
                
                }
        
            }
            
            }.resume()

        
    }
    

    
}
