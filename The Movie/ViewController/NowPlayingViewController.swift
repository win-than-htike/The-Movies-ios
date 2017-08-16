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
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var movieList : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showIndicator()
        
        NotificationCenter.default.addObserver(forName:NSNotification.Name(rawValue: Constants.NotificationKey.NOW_PLAYING_NOTIFICATION_KEY), object:nil, queue:nil, using:loadedNowPlayingMovie)
        
        let cellNib = UINib(nibName : "MovieCollectionViewCell", bundle : nil)
        movieCollectionView.register(cellNib, forCellWithReuseIdentifier: Constants.MovieCellId.CELL_ID)
        movieCollectionView.backgroundColor = UIColor.clear
        NetworkManager.shared().loadNowPlayingMovie(page: 1)
        
    }
    
    func loadedNowPlayingMovie(notification:Notification) -> Void {
        
        if let data = notification.userInfo!["d"] as? [Movie] {
            self.movieList.append(contentsOf: data)
            hideIndicator()
            self.movieCollectionView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.MovieSegue.MOVIE_SEGUE_KEY {
            
            if let dist = segue.destination as? MovieDetailViewController {
                
                dist.movie = sender as! Movie
                
            }
            
        }
        
    }
    
    func showIndicator(){
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        movieCollectionView.addSubview(activityIndicator)
    }
    
    func hideIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MovieCellId.CELL_ID,for: indexPath) as! MovieCollectionViewCell
        
        let currentMovie = movieList[indexPath.row]
        cell.movieImage.sd_setImage(with: URL(string: currentMovie.poster_path))
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.MovieSegue.MOVIE_SEGUE_KEY, sender: self.movieList[indexPath.row])
    }
    
}

extension NowPlayingViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.movieCollectionView.frame.width/4 - 16, height: 120)
        let sideSize = (traitCollection.horizontalSizeClass == .compact &&
            traitCollection.verticalSizeClass == .regular) ? 90.0 : 120.0
        
        return CGSize(width: sideSize - 16, height: 120)
    }
    
    
    
}

