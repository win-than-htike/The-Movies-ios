//
//  NetworkManager.swift
//  The Movie
//
//  Created by Win Than Htike on 8/4/17.
//  Copyright © 2017 Win Than Htike. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftEventBus

class NetworkManager {
    
    init() {
        
    }
    
    static func fetchPopularMovie(_ page : Int) {
        
        var movies : [Movie] = []
        
        Alamofire.request(Constants.MovieApiRoute.POPULAR_MOVIE_URL, parameters : ["api_key": Constants.API_KEY, "page": page])
            .responseJSON { response in
                
                switch (response.result) {
                    
                case .success:
                    
                    let api = response.result.value
                    
                    let json = JSON(api!)
                    
                    let data = json["results"].array
                    
                    if let result = data {
                        
                        result.forEach{ item in
                            
                            let movie : Movie = Movie()
                            movie.title = item["title"].string!
                            movie.overview = item["overview"].string!
                            movie.poster_path = Constants.IMAGE_BASE_PATH + item["poster_path"].string!
                            movies.append(movie)
                            
                        }
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.NotificationKey.POPULAR_NOTIFICATION_KEY), object: nil, userInfo: ["d" : movies])
                        
                    }
                    
                    break
                    
                case .failure:
                    print("request fail")
                    break
                    
                }
                
        }
        
    }
    
    static func fetchNowPlayingMovie(_ page : Int) {
        
        var movies : [Movie] = []
        
        Alamofire.request(Constants.MovieApiRoute.NOW_PLAYING_MOVIE_URL, parameters : ["api_key": Constants.API_KEY, "page": page])
            .responseJSON { response in
                
                switch (response.result) {
                    
                case .success:
                    
                    let api = response.result.value
                    
                    let json = JSON(api!)
                    
                    let data = json["results"].array
                    
                    if let result = data {
                        
                        result.forEach{ item in
                            
                            let movie : Movie = Movie()
                            movie.title = item["title"].string!
                            movie.overview = item["overview"].string!
                            movie.poster_path = Constants.IMAGE_BASE_PATH + item["poster_path"].string!
                            movies.append(movie)
                            
                        }
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.NotificationKey.NOW_PLAYING_NOTIFICATION_KEY), object: nil, userInfo: ["d" : movies])
                        
                    }
                    
                    break
                    
                case .failure:
                    print("request fail")
                    break
                    
                }
                
        }
        
    }
    
    static func fetchUpComingMovie(_ page : Int) {
        
        var movies : [Movie] = []
        
        Alamofire.request(Constants.MovieApiRoute.UPCOMING_MOVIE_URL, parameters : ["api_key": Constants.API_KEY, "page": page])
            .responseJSON { response in
                
                switch (response.result) {
                    
                case .success:
                    
                    let api = response.result.value
                    
                    let json = JSON(api!)
                    
                    let data = json["results"].array
                    
                    if let result = data {
                        
                        result.forEach{ item in
                            
                            let movie : Movie = Movie()
                            movie.title = item["title"].string!
                            movie.overview = item["overview"].string!
                            movie.poster_path = Constants.IMAGE_BASE_PATH + item["poster_path"].string!
                            movies.append(movie)
                            
                        }
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.NotificationKey.UPCOMING_NOTIFICATION_KEY), object: nil, userInfo: ["d" : movies])
                        
                    }
                    
                    break
                    
                case .failure:
                    print("request fail")
                    break
                    
                }
                
        }
        
    }
    
}
