//
//  Constants.swift
//  The Movie
//
//  Created by Win Than Htike on 8/2/17.
//  Copyright © 2017 Win Than Htike. All rights reserved.
//

import Foundation

class Constants{
    
    public static let API_KEY : String = "67e10f963247313db2a79cd4368c1d9f"
    
    public static let IMAGE_BASE_PATH : String = "http://image.tmdb.org/t/p/w500";
    
    struct MovieApiRoute {
        
        public static let POPULAR_MOVIE_URL : String = "http://api.themoviedb.org/3/movie/popular"
        public static let NOW_PLAYING_MOVIE_URL : String = "http://api.themoviedb.org/3/movie/now_playing"
        public static let UPCOMING_MOVIE_URL : String = "http://api.themoviedb.org/3/movie/upcoming"
        public static let TOP_RATED_MOVIE_URL : String = "http://api.themoviedb.org/3/movie/top_rated"
        
    }
    
    struct NotificationKey {
        
        public static let POPULAR_NOTIFICATION_KEY : String = "POPULAR_NOTIFICATION_KEY"
        public static let NOW_PLAYING_NOTIFICATION_KEY : String = "NOW_PLAYING_NOTIFICATION_KEY"
        public static let UPCOMING_NOTIFICATION_KEY : String = "UPCOMING_NOTIFICATION_KEY"
        public static let TOP_RATED_NOTIFICATION_KEY : String = "TOP_RATED_NOTIFICATION_KEY"
        
    }
    
    struct MovieCellId {
        
        public static let CELL_ID = "movieCell"
        
    }
    
}
