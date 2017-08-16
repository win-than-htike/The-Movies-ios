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
    
    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    @IBOutlet weak var upComingCollectionView: UICollectionView!
    
    var movieList : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showIndicator()
        
        NotificationCenter.default.addObserver(forName:NSNotification.Name(rawValue: Constants.NotificationKey.UPCOMING_NOTIFICATION_KEY), object:nil, queue:nil, using:loadedUpcomingMovie)
        
        let cellNib = UINib(nibName : "MovieCollectionViewCell", bundle : nil)
        upComingCollectionView.register(cellNib, forCellWithReuseIdentifier: Constants.MovieCellId.CELL_ID)
        upComingCollectionView.backgroundColor = UIColor.clear
        NetworkManager.shared().loadUpcomingMovie(page: 1)
        
    }
    
    func loadedUpcomingMovie(notification:Notification) -> Void {
        
        if let data = notification.userInfo!["d"] as? [Movie] {
            
            data.forEach{ item in
                self.movieList.append(item)
            }
            
            hideIndicator()
            self.upComingCollectionView.reloadData()
            
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
        upComingCollectionView.addSubview(activityIndicator)
    }
    
    func hideIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.MovieSegue.MOVIE_SEGUE_KEY, sender: self.movieList[indexPath.row])
    }
    
}

extension UpComingViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideSize = (traitCollection.horizontalSizeClass == .compact &&
            traitCollection.verticalSizeClass == .regular) ? 90.0 : 120.0
        
        return CGSize(width: sideSize - 16, height: 120)
    }
    
}
