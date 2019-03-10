//
//  Cache.swift
//  tmdbApi
//
//  Created by air on 3/9/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit

protocol GetImageProtocol {
    func getImage(with url : URL, _ completion : @escaping (_ image: UIImage?) -> ())
}

class Cache{
    
    class var shared: Cache {
        return Cache()
    }
    
    var imageCache = NSCache<NSString, UIImage>()
    
    private func downloadImage(with url : URL, _ completion : @escaping (_ image: UIImage?) -> ()){
        
        //DispatchQueue.main.async {
            do{
                let data = try Data(contentsOf: url)
                let posterImage = UIImage(data: data)!
                self.imageCache.setObject(posterImage, forKey: url.absoluteString as NSString)
                completion(posterImage)
            }catch{
            completion(nil)
            }
        //}
        
    }

    
//    var popularPage = 1
//    var upcomingPage = 0
//    var topRatedPage = 0
//
//    var popularMovies = [MovieModel]()
//    var lastUrlPopular = ""
//
//    var upcomingMovies = [MovieModel]()
//    var lastUrlUpcoming = ""
//
//    var topRatedMovies = [MovieModel]()
//    var lastUrlTopRated = ""
    
}

extension Cache : GetImageProtocol{
    
    func getImage(with url: URL, _ completion: @escaping (UIImage?) -> ()) {
        if let image = imageCache.object(forKey: url.absoluteString as NSString){
            completion(image)
        }else{
            downloadImage(with: url, completion)
        }

    }
    
    
}

//extension Cache : UploadCachingData{
//
//    func readPage(with url: String, view : CurrentView) -> [MovieModel] {
//        switch view {
//        case .popular:
//            return popularMovies
//        case .upcoming:
//            return upcomingMovies
//        case .top_rated:
//            return topRatedMovies
//        case .none:
//            return []
//        }
//    }
//
//
//}
//
//extension Cache : CachingData{
//
//    func saveImage(movies : [MovieModel], with url : String, view : CurrentView) {
//
//        switch view {
//        case .popular:
//
//            lastUrlPopular = url
//            for movie in movies{
//                popularMovies.append(movie)
//            }
//            print(popularMovies.count)
//
//            break
//        case .upcoming:
//
//            lastUrlUpcoming = url
//            for movie in movies{
//                upcomingMovies.append(movie)
//            }
//
//            break
//        case .top_rated:
//
//            lastUrlTopRated = url
//            for movie in movies{
//                topRatedMovies.append(movie)
//            }
//
//            break
//        case .none:
//            break
//        }
//
//    }
//
//

    
//
//    func getImage(with url : URL, _ completion : @escaping (_ image: UIImage?) -> ()) {
//        if let image = imageCache.object(forKey: url.absoluteString as NSString){
//            //print("from cahce")
//            completion(image)
//        }else{
//            downloadImage(with: url, completion)
//        }
//    }

    
    

