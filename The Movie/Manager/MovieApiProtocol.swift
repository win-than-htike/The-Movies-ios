//
//  MovieApiProtocol.swift
//  The Movie
//
//  Created by Win Than Htike on 8/7/17.
//  Copyright © 2017 Win Than Htike. All rights reserved.
//

import Foundation

protocol MovieApiProtocol {
    
    func loadNowPlayingMovie(page : Int) -> Void
    func loadUpcomingMovie(page : Int) -> Void
    func loadPopularMovie(page : Int) -> Void
    func loadTopRatedMovie(page : Int) -> Void
    
}
