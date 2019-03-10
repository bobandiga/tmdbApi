//
//  Utils.swift
//  tmdbApi
//
//  Created by air on 3/7/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

protocol FetchDataProtocol {
    func fetchData(with url : String, _ block : @escaping (JSON?) -> ())
    
}

protocol ParseDataProtocol {
    func parseData(with data : JSON?, parseType : ParseType) -> [Any]
    
}

enum ParseType {
    case movies
    case movieDetail
}


enum CurrentView : String{
    case popular = "popular"
    case top_rated = "top_rated"
    case upcoming = "upcoming"
    case none = ""
}

enum LanguageType : String{
    case en = "en"
    case ru = "ru"
}

class URLString {
    
    private static var last = CurrentView.popular
    
    private static var popularPage = 1
    private static var top_ratedPage = 1
    private static var upcomingPage = 1
    
    static func url(with viewType : CurrentView = last, language : LanguageType, loadMore : Bool = false) -> String{
        
        var page : Int = 0
        
        switch viewType {
            
        case .popular:
            
            if loadMore{
                popularPage += 1
            }else{
                popularPage = 1
            }
            
            page = popularPage
            
        case .top_rated:
            
            if loadMore{
                top_ratedPage += 1
            }else{
                top_ratedPage = 1
            }
            
            page = top_ratedPage
            
        case .upcoming:
            
            if loadMore{
                upcomingPage += 1
            }else{
                upcomingPage = 1
            }
            
            page = upcomingPage
            
        case .none:
            break
        }
        
        last = viewType
        
        return "https://api.themoviedb.org/3/movie/\(viewType.rawValue)?api_key=\(API_KEY)&language=\(language.rawValue)-US&page=\(page)"
    }
    
}


class Worker  : FetchDataProtocol, ParseDataProtocol{
    
    func fetchData(with url: String, _ block: @escaping (JSON?) -> ()) {
        let req = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15)
        
//        if let response = URLCache.shared.cachedResponse(for: req){
//            do{
//                let json = try JSON(data: response.data)
//                block(json)
//            }catch{
//                block(nil)
//            }
//        }else{
            request(req).validate().responseJSON { (response) in
                if response.response?.statusCode == 200{
                    
//                    if response.data != nil, response.response != nil{
//                        URLCache.shared.storeCachedResponse(CachedURLResponse(response: response.response!, data: response.data!), for: req)
//                    }
                    do{
                        let json = try JSON(data: response.data!)
                        block(json)
                    }catch{
                        block(nil)
                    }
                }else{
                    block(nil)
                }
            }
//        }
    }
    
    func parseData(with data: JSON?, parseType: ParseType) -> [Any] {
        
        switch parseType {
        case .movies:
            
            var array : [MovieModel] = []
            
            if let json = data {
                
                let resultArray = json["results"].arrayValue
                
                for result in resultArray{
                    
                    let id = result["id"].stringValue
                    let title = result["title"].stringValue
                    let originalTitle = result["original_title"].stringValue
                    let posterPath = result["poster_path"].stringValue
                    
                    let imageUrl = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")!
                    
                    var posterImage : UIImage? = nil
                    
                    Cache.shared.getImage(with: imageUrl) { (image) in
                        posterImage = image
                    }
                    
                    let releaseDate = result["release_date"].stringValue
                    let voteAvarage = result["vote_average"].stringValue
                    let overview = result["overview"].stringValue
                    
                    let movie = MovieModel(id: id, title: title, originalTitle: originalTitle, posterImage: posterImage, imagePath: imageUrl, releaseDate: releaseDate, voteAvarage: voteAvarage, overview: overview, genres: [], companies: [])
                    array.append(movie)
                }

                
                return array
                
            }else{
            
                return []
                
            }
        case .movieDetail:
            
            var genres : [String] = []
            var companies : [String] = []
            
            if let json = data{
                for genre in json["genres"].arrayValue{
                    genres.append(genre["name"].stringValue)
                }
                for company in json["production_companies"].arrayValue{
                    companies.append(company["name"].stringValue)
                }
  
                return [genres, companies]
                
            }else{
                return []
            }
        default:
            return []
        }
        
    }

}

