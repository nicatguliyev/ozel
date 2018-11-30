//
//  PhotosViewController.swift
//  Portal1
//
//  Created by Nicat Guliyev on 11/11/18.
//  Copyright © 2018 Nicat Guliyev. All rights reserved.
//

import UIKit


struct PhotoModel: Decodable{
    let data: [PhotoDataModel]
}

struct VideoModel: Decodable {
    let data: [VideoDataModel]
}

struct PhotoDataModel: Decodable {
    let id: Int
    let image: String
    let created_at: String
    
}

struct VideoDataModel: Decodable {
    let id: Int
    let youtube_id: String
    let created_at: String
}

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var splashScreen: UIView!
    @IBOutlet weak var photoCollectioView: UICollectionView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var reloadView: UIView!
    @IBOutlet weak var splashIndicator: UIActivityIndicatorView!
    
    
    var selectedImage: UIImage?
    var selectedVideo = ""
    
    var leftButton = UIButton()
    var rightButton = UIButton()
    var images = [String]()
    var videoIds = [String]()
    var firstTime = 0
    var photoTask = URLSession.shared.dataTask(with: URL(string: "http://142.93.186.89/api/v1/gallery/images")!)
    var videoTask = URLSession.shared.dataTask(with: URL(string: "http://142.93.186.89/api/v1/gallery/videos)")!)
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.layer.cornerRadius = 10
        segmentedControl.layer.masksToBounds = true
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.borderColor = UIColor.blue.cgColor
        
        let navBarColor = UIColor(red: 13/255, green: 140/255 , blue: 207/255, alpha: 1);
        let navBar = self.navigationController?.navigationBar
        
        navBar?.barTintColor = navBarColor
        navBar?.isTranslucent = false
        
        let customNavBar = CustomNavigationBar()
        leftButton = UIButton(type: UIButtonType.custom)
        rightButton = UIButton(type: UIButtonType.custom)
        leftButton.addTarget(self, action: #selector(exitPhotos), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(nothing), for: UIControlEvents.touchUpInside)
        customNavBar.createButtonsAndTittle(viewController: self, leftButton: leftButton, rightBtn: rightButton, type: 2)

        
        getPhotos()
        
        
        let reloadGesture = UITapGestureRecognizer(target: self, action: #selector(reloadTapped))
        reloadView.addGestureRecognizer(reloadGesture)
        reloadView.isUserInteractionEnabled = true
        
    }
    
    @objc func reloadTapped() {
        if(segmentedControl.selectedSegmentIndex == 0)
        {
        getPhotos()
        }
        else
        {
        getVideos()
        }
    }
    
    @objc func nothing(){
        
    }
    
    @objc func exitPhotos()
    {
       self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == photoCollectioView)
        {
            return self.images.count
        }
        else
        {
            return self.videoIds.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == photoCollectioView)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
            
            if(images.count != 0)
            {
            
                
                cell.loadImageFromUrl(url: images[indexPath.row])
         
            }
            
            return cell
        }
        
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCollectionViewCell
            
            if(videoIds.count != 0)
            {
                cell.loadImageFromUrl(id: videoIds[indexPath.row])
            }
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == photoCollectioView)
        {
            let selectedCell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
            
            selectedImage = selectedCell.photoImage.image
            
            performSegue(withIdentifier: "PhotoDetail", sender: self)
        }
        
        else{
            
            //selectedVideo = "youtube://www.youtube.com/watch?v=" + videoIds[indexPath.row]
            
            selectedVideo = "youtube://" + videoIds[indexPath.row]
            
          //  performSegue(withIdentifier: "SegueToYoutube", sender: self)
            
            UIApplication.shared.canOpenURL(URL(string: selectedVideo)!)
            
            if let youtubeUrl = URL(string: selectedVideo){
              
                    UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
            }
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
         return CGSize(width: (collectionView.frame.size.width - 6)/3, height: (collectionView.frame.size.width - 6)/3)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    

    
    @IBAction func segmentCtrlChanged(_ sender: Any) {
        
        let getIndex = segmentedControl.selectedSegmentIndex
        
        switch (getIndex) {
        case 0:
            photoCollectioView.isHidden = false
            videoCollectionView.isHidden = true
            
            if(images.count == 0){
                getPhotos()
            }
            else{
                splashScreen.isHidden = true
            }
            
        case 1:
            photoCollectioView.isHidden = true
            videoCollectionView.isHidden = false
            
            if(videoIds.count == 0)
            {
                getVideos()
            }
            else
            {
                splashScreen.isHidden = true
            }
        default:
            print()
        }
    }
    
    func getPhotos() {
        
        print("HUHUHUHU")
        splashScreen.isHidden = false
        photoCollectioView.isHidden = true
        splashIndicator.isHidden = false
        reloadView.isHidden = true
        
        let urlString = "http://142.93.186.89/api/v1/gallery/images"
        
        guard let url = URL(string: urlString)
            else {return}
        
       let task =  URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            if (err == nil) {
                guard let data = data else { return }
                
                
                do{
                    let photos = try JSONDecoder().decode(PhotoModel.self, from: data)
                    
                    for i in 0..<photos.data.count{
                        print(photos.data[i])
                        self.images.append(photos.data[i].image)
                    }
                    
                }
                    
                catch let jsonError {
                    print("Error bas verdi " , jsonError)
                }
                    
                    DispatchQueue.main.async {
                        self.photoCollectioView.reloadData()
                        self.photoCollectioView.isHidden = false
                        self.splashScreen.isHidden = true
                    }
                
            }
            
            else
            {
                if let error = err as? NSError
                {
                    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorCannotConnectToHost{
                        DispatchQueue.main.async {
                            
                            self.splashScreen.isHidden = false
                            self.reloadView.isHidden = false
                            self.splashIndicator.isHidden = true
                            
                        }
                    }
                }
            }
            }
        
          photoTask = task
          photoTask.resume()
          videoTask.cancel()
        
    }
    
    func getVideos() {
        
        splashScreen.isHidden = false
        videoCollectionView.isHidden = true
        splashIndicator.isHidden = false
        reloadView.isHidden = true
        
        let urlString = "http://142.93.186.89/api/v1/gallery/videos"
        
        guard let url = URL(string: urlString)
            else {return}
        
       let task = URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            if(err == nil){
            
            guard let data = data else { return }
            
            
            do{
                let videos = try JSONDecoder().decode(VideoModel.self, from: data)
                
                for i in 0..<videos.data.count{
                    print(videos.data[i])
                    self.videoIds.append(videos.data[i].youtube_id)
                }
                
            }
                
            catch let jsonError {
                print("Error bas verdi " , jsonError)
            }
            
            
                
                DispatchQueue.main.async {
                    //self.photoCollectioView.reloadData()
                    self.videoCollectionView.reloadData()
                    self.videoCollectionView.isHidden = false
                    self.splashScreen.isHidden = true
                }
                
            
            }
            
            else
            {
                if let error = err as? NSError
                {
                    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorCannotConnectToHost{
                        DispatchQueue.main.async {
                            self.splashScreen.isHidden = false
                            self.reloadView.isHidden = false
                            self.splashIndicator.isHidden = true
                        }
                    }
                }
            }
            
            }
        
        videoTask = task
        videoTask.resume()
        photoTask.cancel()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoDetail"
        {
            let destinationVC = segue.destination as! PhotoDetailViewController
            
            destinationVC.selectedImage = self.selectedImage
            
        }
        
        if segue.identifier == "SegueToYoutube"
        {
            let destinationVC = segue.destination as! YoutubeViewController
            
            destinationVC.videoUrlString = self.selectedVideo
            
        }
        
    }
   
    
    
}
