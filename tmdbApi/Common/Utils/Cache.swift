//
//  Cache.swift
//  tmdbApi
//
//  Created by air on 3/9/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit

protocol CachingData {
    func savePage(movies : [MovieModel], with url: String, urlType : URLType)
}

protocol CachingImages {
    func saveImage()
}

protocol UploadCachingData {
    func readPage(with url: String, urlType : URLType) -> [MovieModel]
}

protocol LoadData {
    func loadData()
}

class Cache{
    
    class var shared: Cache {
        return Cache()
    }
    
    var imageCache = NSCache<NSString, UIImage>()
    
    var popularPage = 1
    var upcomingPage = 0
    var topRatedPage = 0
    
    var popularMovies = Dictionary<String, [MovieModel]>()
    var upcomingMovies = Dictionary<String, [MovieModel]>()
    var topRatedMovies = Dictionary<String, [MovieModel]>()
    
}

extension Cache : UploadCachingData{
    
    func readPage(with url: String, urlType : URLType) -> [MovieModel] {
        switch urlType {
        case .popular:
            return popularMovies[url] ?? []
        case .upcoming:
            return upcomingMovies[url] ?? []
        case .top_rated:
            return topRatedMovies[url] ?? []
        case .none:
            return []
        }
    }
    
    
}

extension Cache : CachingData{
    
    func savePage(movies : [MovieModel], with url : String, urlType : URLType) {
        switch urlType {
        case .popular:
                popularMovies[url] = movies
            break
        case .upcoming:
                upcomingMovies[url] = movies
            break
        case .top_rated:
                topRatedMovies[url] = movies
            break
        case .none:
            break
        }
        
    }
    
    
    
    
//    func downloadImage(with url : URL, _ completion : @escaping (_ image: UIImage?) -> ()){
//
//        do{
//            let data = try Data(contentsOf: url)
//            let posterImage = UIImage(data: data)!
//            imageCache.setObject(posterImage, forKey: url.absoluteString as NSString)
//            completion(posterImage)
//        }catch{
//            completion(nil)
//        }
//
//        //print("download")
//
//
//    }
//
//    func getImage(with url : URL, _ completion : @escaping (_ image: UIImage?) -> ()) {
//        if let image = imageCache.object(forKey: url.absoluteString as NSString){
//            //print("from cahce")
//            completion(image)
//        }else{
//            downloadImage(with: url, completion)
//        }
//    }

    
    
}
