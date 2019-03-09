//
//  MainInteractor.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    
    var mainWorker: MainWorker?
    var presenter: MainPresenterProtocol?
    
    func fetchData(with url: String, urlType: URLType) {
        
        print("fetch data \(url)")
        
        if Cache.shared.readPage(with: url, urlType: urlType).isEmpty{
            mainWorker?.fetchData(with: url, { (json) in
                let array = self.mainWorker?.parseData(with: json, parseType: .movies) as! [MovieModel]
                self.presenter?.outputData(json: array)
                Cache.shared.savePage(movies: array, with: url, urlType: urlType)
            })
        }else{
            print("from chache")
            presenter?.outputData(json: Cache.shared.readPage(with: url, urlType: urlType))
        }
        
        
    }
    
    func fetchDataFromLoadButton(with url: String) {
        
    }
    
    func fetchDataFromMenuButton(with url: String, urlType : URLType) {
        
    }
    
    func fetchData(with url: String){
    
        print("fetch data \(url)")
        
        mainWorker?.fetchData(with: url, { (json) in
            let array = self.mainWorker?.parseData(with: json, parseType: .movies) as! [MovieModel]
            self.presenter?.outputData(json: array)
            
            
            
        })
    }
    
    func fetchImage(for models: [MovieModel]?, _ block: @escaping ([MovieModel]) -> ()) {
        
        var array = [MovieModel]()
        
        if let models = models{
            for model in models{
                mainWorker?.getImageFromModel(model: model, { (image) in
                    
                    let movie = MovieModel(id: model.id, title: model.title, originalTitle: model.originalTitle, posterImage: image, imagePath: model.imagePath, releaseDate: model.releaseDate, voteAvarage: model.voteAvarage, overview: model.overview, genres: [model.genres], companies: [model.companies])
                    array.append(movie)
                })
                block(array)
            }
        }else{
            block(array)
        }
        
    }
    
//    func fetchData(with url: String, block: @escaping ([JSON]) -> ()) {
//        print("fetching")
//        request(URL(string: url)!).validate().responseJSON { (response) in
//            if response.response?.statusCode == 200{
//                let data = response.data
//                do{
//                    let json = try JSON(data: data!)
//                    let resultArray = json["results"].arrayValue
//                    block(resultArray)
//                }catch{
//                    print("error")
//                    block([])
//                }
//                
//                
//                
//            }else{
//                print("error")
//                block([])
//            }
//        }
        
//    }
    
    
}
