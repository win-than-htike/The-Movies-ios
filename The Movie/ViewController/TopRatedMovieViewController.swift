//
//  TopRatedMovieViewController.swift
//  The Movie
//
//  Created by Win Than Htike on 8/7/17.
//  Copyright © 2017 Win Than Htike. All rights reserved.
//

import UIKit

class TopRatedMovieViewController: UIViewController {
    
    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    
    var movieList : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showIndicator()
        
        NotificationCenter.default.addObserver(forName:NSNotification.Name(rawValue: Constants.NotificationKey.TOP_RATED_NOTIFICATION_KEY), object:nil, queue:nil, using:loadedTopRatedMovie)
        
        let cellNib = UINib(nibName : "MovieCollectionViewCell", bundle : nil)
        topRatedCollectionView.register(cellNib, forCellWithReuseIdentifier: Constants.MovieCellId.CELL_ID)
        topRatedCollectionView.backgroundColor = UIColor.clear
        NetworkManager.shared().loadTopRatedMovie(page: 1)
        
    }
    
    func loadedTopRatedMovie(notification:Notification) -> Void {
        
        if let data = notification.userInfo!["d"] as? [Movie] {
            
            data.forEach{ item in
                self.movieList.append(item)
            }
            
            hideIndicator()
            self.topRatedCollectionView.reloadData()
            
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
        topRatedCollectionView.addSubview(activityIndicator)
    }
    
    func hideIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

}

extension TopRatedMovieViewController : UICollectionViewDataSource {
    
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

extension TopRatedMovieViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideSize = (traitCollection.horizontalSizeClass == .compact &&
            traitCollection.verticalSizeClass == .regular) ? 90.0 : 120.0
        
        return CGSize(width: sideSize - 16, height: 120)
    }
    
}

