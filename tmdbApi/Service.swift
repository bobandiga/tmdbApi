//
//  Service.swift
//  tmdbApi
//
//  Created by air on 2/23/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class Service {
    
    enum Request : String{
        case popular = "popular"
        case topRated = "top_rated"
        case upcoming = "upcoming"
    }
    
    private let apiKey = "32eeaecb997dcef09b7f0b740f9a1b08"
    private let language = "ru"
    
    let cache = Cache()
    
    func showError(activityIndicator : ActivityIndicator, _ block : @escaping () -> ()){
        if !Connectivity.isConnectedToInternet(){
            let alertC = UIAlertController(title: "Error", message: "Lost internet connection", preferredStyle: .actionSheet)
            alertC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
                activityIndicator.stopAnimating()
                block()
            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alertC, animated: true, completion: nil)
        }
    }
    
    func fetchDetails(activityIndicator : ActivityIndicator, movieId : String, _ block : @escaping (_ genres : [String]?, _ productionCompanies : [String]?) -> (), _ finished : @escaping () -> ()){
        
        activityIndicator.startAnimating()
        
        var arrayGenres = [String]()
        var arrayCompanies = [String]()
        
        let url = URL(string :"https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)&language=\(language)-US")!
        let r = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 15)
        
        request(r).responseJSON { (response) in
            
            if response.error != nil{
                block(nil, nil)
                self.showError(activityIndicator: activityIndicator) {
                    finished()
                    return
                }
            }
            
            if response.result.isSuccess, let data = response.data{
                
                do{
                    let json = try JSON(data: data)
                    for genre in json["genres"].arrayValue{
                        arrayGenres.append(genre["name"].stringValue)
                    }
                    for company in json["production_companies"].arrayValue{
                        arrayCompanies.append(company["name"].stringValue)
                    }
                    block(arrayGenres,arrayCompanies)
                }catch{
                    block(nil,nil)
                }
                
            }
            activityIndicator.stopAnimating()
            finished()
        }
    }
    
    func fetch(activityIndicator : ActivityIndicator, r : Request, page : Int = 1, _ block : @escaping (_ movies : [MovieModel]? ) -> (), _ finished :  (() -> ())? = nil){
        
        activityIndicator.startAnimating()
        
        var array = [MovieModel]()
        
        let basicUrl = "https://api.themoviedb.org/3/movie/\(r.rawValue)?api_key=\(apiKey)&language=\(language)-US&page="
        let url = URL(string: basicUrl + "\(page)")!
        print(url.absoluteString)
        var isCache = false
        
        cache.uploadDataWith(URLRequest(url: url)) { (json) in

            if let json = json {
                let resultArray = json["results"].arrayValue

                for result in resultArray{

                    let id = result["id"].stringValue
                    let title = result["title"].stringValue
                    let originalTitle = result["original_title"].stringValue
                    let posterPath = result["poster_path"].stringValue

                    let imageUrl = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")!
                    var posterImage : UIImage?

                    self.cache.getImage(with: imageUrl, { (image) in
                        posterImage = image
                    })

                    let releaseDate = result["release_date"].stringValue
                    let voteAvarage = result["vote_average"].stringValue
                    let overview = result["overview"].stringValue
                    
                    let movie = MovieModel(id: id, title: title, originalTitle: originalTitle, posterImage: posterImage ?? UIImage(named: "question"), releaseDate: releaseDate, voteAvarage: voteAvarage, overview: overview, genres: [], companies: [])
                    array.append(movie)
                }
                isCache = true
                block(array)

            }
            activityIndicator.stopAnimating()
            finished!()
        }
        if isCache == false{
        let req = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 15)
            request(req).validate().responseJSON { (response) in
            if response.error != nil{
                block(nil)
                self.showError(activityIndicator: activityIndicator) {
                    self.fetch(activityIndicator: activityIndicator, r: r, page: page, { (t) in
                        block(t)
                        return
                    })
                }
            }
        
            if response.result.isSuccess, let data = response.data{
               
                    do{
                        
                        self.cache.saveDataWith(response.response!, data, urlRequest: response.request!)
                        
                        let json = try JSON(data: data)
                        let resultArray = json["results"].arrayValue
                        
                        for result in resultArray{
                            
                            let id = result["id"].stringValue
                            let title = result["title"].stringValue
                            let originalTitle = result["original_title"].stringValue
                            let posterPath = result["poster_path"].stringValue
                            
                            let imageUrl = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")!
                            //imageUrls.append(imageUrl!)
                            var posterImage : UIImage?
                            
                            self.cache.getImage(with: imageUrl, { (image) in
                                posterImage = image
                            })
                        
                            let releaseDate = result["release_date"].stringValue
                            let voteAvarage = result["vote_average"].stringValue
                            let overview = result["overview"].stringValue
                            
                            let movie = MovieModel(id: id, title: title, originalTitle: originalTitle, posterImage: posterImage ?? UIImage(named: "question"), releaseDate: releaseDate, voteAvarage: voteAvarage, overview: overview, genres: [], companies: [])
                            array.append(movie)
                        }
                        
                        block(array)
                        
                    }catch{
                        block(nil)
                    }
                }
            activityIndicator.stopAnimating()
        }
            finished?()
        }
        
    }
    
    func fetchImage(for movies : [MovieModel], with urls : [URL], _ block : @escaping ([MovieModel])->()){
        var movies = [MovieModel]()
        for (index,movie) in movies.enumerated(){
            var myMovie = movie
            cache.getImage(with: urls[index]) { (image) in
                if let image = image{
                    myMovie.posterImage = image
                    movies.append(myMovie)
                }
            }
            block(movies)
        }
        
    }
    
}


class Cache : URLCache{
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    override init() {
        
        let memoryCapacity = 128 * 1024 * 1024
        let diskCapacity = 128 * 1024 * 1024
        
        super.init(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        self.removeAllCachedResponses()
    }
    

    
    
    func saveDataWith(_ response : URLResponse, _ data : Data, urlRequest : URLRequest){
        let c = CachedURLResponse(response: response, data: data)
        self.storeCachedResponse(c, for: urlRequest)
    }
    
    func uploadDataWith(_ urlRequest : URLRequest, _ block : (JSON?) -> ()){
        if self.cachedResponse(for: urlRequest) != nil{
            if let data = self.cachedResponse(for: urlRequest){
                do{
                    let json = try JSON(data: (data.data))
                    block(json)
                }catch{
                    //print(error.localizedDescription)
                    block(nil)
                }

            }
        }
    }
    
    func downloadImage(with url : URL, _ completion : @escaping (_ image: UIImage?) -> ()){
        
        do{
            let data = try Data(contentsOf: url)
            let posterImage = UIImage(data: data)!
            imageCache.setObject(posterImage, forKey: url.absoluteString as NSString)
            completion(posterImage)
        }catch{
            completion(nil)
        }
        
        //print("download")
                
        
    }
    
    func getImage(with url : URL, _ completion : @escaping (_ image: UIImage?) -> ()) {
        if let image = imageCache.object(forKey: url.absoluteString as NSString){
            //print("from cahce")
            completion(image)
        }else{
            downloadImage(with: url, completion)
        }
    }
    
    func executionTimeInterval(block: () -> ()) -> CFTimeInterval {
        let start = CACurrentMediaTime()
        block();
        let end = CACurrentMediaTime()
        return end - start
    }
    
}
