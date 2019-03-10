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
    
    func fetchData(with url: String) {
        
        mainWorker?.fetchData(with: url, { (json) in
            if let array = self.mainWorker?.parseData(json: json){
                if url.last == "1"{
                    self.presenter?.outputData(json: array, append : false)
                }else{
                    self.presenter?.outputData(json: array, append : true)
                }
            }
        })
        
    }
    
    
//    func fetchImage(for models: [MovieModel]?, _ block: @escaping ([MovieModel]) -> ()) {

//        var array = [MovieModel]()
//
//        if let models = models{
//            for model in models{
//                mainWorker?.getImageFromModel(model: model, { (image) in
//
//                    let movie = MovieModel(id: model.id, title: model.title, originalTitle: model.originalTitle, posterImage: image, imagePath: model.imagePath, releaseDate: model.releaseDate, voteAvarage: model.voteAvarage, overview: model.overview, genres: [model.genres], companies: [model.companies])
//                    array.append(movie)
//                })
//                block(array)
//            }
//        }else{
//            block(array)
//        }

//    }
    
}
