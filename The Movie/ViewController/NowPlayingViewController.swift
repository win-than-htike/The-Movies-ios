//
//  NowPlayingViewController.swift
//  The Movie
//
//  Created by Win Than Htike on 8/1/17.
//  Copyright © 2017 Win Than Htike. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class NowPlayingViewController: UIViewController {
    
    private let cellId = "movieCell"
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var movieList : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName:NSNotification.Name(rawValue: Constants.NotificationKey.NOW_PLAYING_NOTIFICATION_KEY), object:nil, queue:nil, using:loadedPopularMovie)
        
        let cellNib = UINib(nibName : "MovieCollectionViewCell", bundle : nil)
        movieCollectionView.register(cellNib, forCellWithReuseIdentifier: cellId)
        movieCollectionView.backgroundColor = UIColor.clear
        NetworkManager.fetchNowPlayingMovie(1)
        
    }
    
    func loadedPopularMovie(notification:Notification) -> Void {
        
        if let data = notification.userInfo!["d"] as? [Movie] {
            
            data.forEach{ item in
                self.movieList.append(item)
            }
            
            self.movieCollectionView.reloadData()
            
        }
        
    }
    
}

extension NowPlayingViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,for: indexPath) as! MovieCollectionViewCell
        
        let currentMovie = movieList[indexPath.row]
        cell.movieImage.sd_setImage(with: URL(string: currentMovie.poster_path))
        
        return cell
        
    }
    
}

extension NowPlayingViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.movieCollectionView.frame.width/4 - 16, height: 120)
    }
    
}

