//
//  MovieDetailViewController.swift
//  The Movie
//
//  Created by Win Than Htike on 8/7/17.
//  Copyright © 2017 Win Than Htike. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    
    var movie : Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieImage.sd_setImage(with: URL(string: movie.poster_path))
        movieTitle.text = movie.title
        movieDesc.text = movie.overview
        
    }

}
