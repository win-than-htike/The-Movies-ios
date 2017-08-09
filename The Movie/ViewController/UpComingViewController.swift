//
//  UpComingViewController.swift
//  The Movie
//
//  Created by Win Than Htike on 8/4/17.
//  Copyright © 2017 Win Than Htike. All rights reserved.
//

import UIKit
import SDWebImage

class UpComingViewController: UIViewController {
    
    
    @IBOutlet weak var upComingCollectionView: UICollectionView!
    
    var movieList : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName:NSNotification.Name(rawValue: Constants.NotificationKey.UPCOMING_NOTIFICATION_KEY), object:nil, queue:nil, using:loadedUpcomingMovie)
        
        let cellNib = UINib(nibName : "MovieCollectionViewCell", bundle : nil)
        upComingCollectionView.register(cellNib, forCellWithReuseIdentifier: Constants.MovieCellId.CELL_ID)
        upComingCollectionView.backgroundColor = UIColor.clear
        NetworkManager.fetchUpComingMovie(1)
        
    }
    
    func loadedUpcomingMovie(notification:Notification) -> Void {
        
        if let data = notification.userInfo!["d"] as? [Movie] {
            
            data.forEach{ item in
                self.movieList.append(item)
            }
            
            self.upComingCollectionView.reloadData()
            
        }
        
    }

}

extension UpComingViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MovieCellId.CELL_ID,for: indexPath) as! MovieCollectionViewCell
        
        let currentMovie = movieList[indexPath.row]
        cell.movieImage.sd_setImage(with: URL(string: currentMovie.poster_path))
        
        return cell
        
    }
    
}

extension UpComingViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.upComingCollectionView.frame.width/4 - 16, height: 120)
    }
    
}
