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

protocol FetchImageFromURL {
    func getImageFromModel(model : MovieModel, _ block : @escaping (UIImage?) -> ())
}

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


enum URLType : String{
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
    
    private static var last = URLType.popular
    
    private static var popularPage = 1
    private static var top_ratedPage = 1
    private static var upcomingPage = 1
    
    static func url(with urlType : URLType = last, language : LanguageType, loadMore : Bool = false) -> String{
        
        var page : Int = 0
        
        switch urlType {
            
        case .popular:
            page = popularPage
            
            if loadMore{
                popularPage += 1
            }
            
        case .top_rated:
            page = top_ratedPage
            
            if loadMore{
                top_ratedPage += 1
            }
            
        case .upcoming:
            page = upcomingPage
            
            if loadMore{
                upcomingPage += 1
            }
            
        case .none:
            break
        }
        
        last = urlType
        
        return "https://api.themoviedb.org/3/movie/\(urlType.rawValue)?api_key=\(API_KEY)&language=\(language.rawValue)-US&page=\(page)"
    }
    
}


class Worker  : FetchDataProtocol, ParseDataProtocol{
    
    func fetchData(with url: String, _ block: @escaping (JSON?) -> ()) {
        let req = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 15)
        request(req).validate().responseJSON { (response) in
            if response.response?.statusCode == 200{
                do{
                    let json = try JSON(data: response.data!)
                    //print(json)
                    block(json)
                }catch{
                    block(nil)
                }
            }else{
                block(nil)
            }
        }
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
                    
                    let releaseDate = result["release_date"].stringValue
                    let voteAvarage = result["vote_average"].stringValue
                    let overview = result["overview"].stringValue
                    
                    let movie = MovieModel(id: id, title: title, originalTitle: originalTitle, posterImage: posterImage ?? UIImage(named: "question"), imagePath: imageUrl, releaseDate: releaseDate, voteAvarage: voteAvarage, overview: overview, genres: [], companies: [])
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
                
            }
            
            return []
        default:
            return []
        }
        
    }
    
    
    
}

extension Worker : FetchImageFromURL{
    
    func getImageFromModel(model: MovieModel, _ block: @escaping (UIImage?) -> ()) {
        
        //Check in cache
        
        var image : UIImage? = nil
        
        request(model.imagePath).validate().responseJSON { (response) in
            if response.response?.statusCode == 200{
                print("ASDASDASDASDASDASDASD")
                image = UIImage(data: response.data!)
                block(image)
            }else{
                block(image)
            }
        }
    }
    
}

