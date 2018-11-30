//
//  XeberlerViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/11/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit

struct PostNewsModel: Decodable {
    let data: [PostNewsDataModel]
    let next_page_url: String?
    
}

struct PostNewsDataModel: Decodable {
    let id: Int
    let title: String
    let image: String
    let created_at: String
}

class XeberlerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var newImage = [String]()
    var postNews = [PostNewsDataModel]()
    var clickedButtonIndex = 0
    var leftButton = UIButton()
    var rightButton = UIButton()
    @IBOutlet weak var mainIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var reloadCompleted = false
    var currentPage = 1
    var reachedLastPage = false
    @IBOutlet weak var bottomIndicator: UIActivityIndicatorView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var selectedPostNew: PostNewsDataModel?
    var imageCash = [Int: UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarColor = UIColor(red: 13/255, green: 140/255 , blue: 207/255, alpha: 1);
        let navBar = self.navigationController?.navigationBar
        
        navBar?.barTintColor = navBarColor
        navBar?.isTranslucent = false
        
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(exitXeberler), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)
        
        collectionView.isHidden = true
        
        getPostNews(page: currentPage)
        
        bottomConstraint.constant = 0
        
        
        
    }
    
    @objc func nothing(){
        
    }
    
    @objc func exitXeberler()
    {
        self.navigationController?.popViewController(animated: true)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCollectionViewCell
        
        print("Yenicell")
        cell.newsNameLbl.text = postNews[indexPath.row].title
        cell.newsImage.layer.cornerRadius = 10
        cell.newsImage.layer.masksToBounds = true
        cell.dateLbl.text = postNews[indexPath.row].created_at
        cell.newsImage.image = nil
        //cell.newsImage.image = UIImage(named: newImage[indexPath.row])
        cell.readmoreBtn.layer.borderWidth = 2
        cell.readmoreBtn.layer.borderColor = UIColor(red: 13/255, green: 140/255, blue: 207/255, alpha: 1).cgColor
        cell.readmoreBtn.layer.cornerRadius = 10
        cell.readmoreBtn.layer.masksToBounds = true
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
        
        cell.readmoreBtn.tag = indexPath.row
        cell.readmoreBtn.addTarget(self, action: #selector(goToNewsDetail), for: UIControlEvents.touchUpInside)
        
        if(imageCash[indexPath.row] == nil)
        {
            if(newImage.count != 0)
            {
                //   cell.loadImageFromUrl(url: newImage[indexPath.row])
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
        
        else {
            
            cell.newsImage.image = imageCash[indexPath.row]
            cell.imageIndicator.isHidden = true
            cell.newsImage.isHidden = false
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedPostNew = postNews[indexPath.row]
        performSegue(withIdentifier: "SegueToDetail", sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth =  screenSize.width
        return CGSize(width: screenWidth - CGFloat(32), height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(10, 0, 10, 0)
    }
    
    @objc func goToNewsDetail(sender: UIButton){
        
       selectedPostNew = postNews[sender.tag]
       performSegue(withIdentifier: "SegueToDetail", sender: self)
    
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
                    self.collectionView.isHidden = false
                    self.collectionView.reloadData()
                    self.reloadCompleted = true
                    self.bottomIndicator.isHidden = true
                    self.bottomConstraint.constant = 0
          
                }
                
            }
            
            }.resume()
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
           if(reloadCompleted == true)
           {
            if(reachedLastPage == false)
            {
            bottomIndicator.isHidden = false
            bottomConstraint.constant = 50
            getPostNews(page: currentPage)
            reloadCompleted = false
            }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NewsDetailViewController
        destinationVC.newsType = "Post"
        destinationVC.selectedPostNew = self.selectedPostNew
    }
    



}
