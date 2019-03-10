//
//  DetailPresenter.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import SwiftyJSON

class DetailPresenter : DetailPresenterProtocol{
    
    weak var view : DetailViewControllerProtocol?
    var interactor: DetailInteractorProtocol?
    var wireframe: DetailWireframeProtocol?
    
    var movie: MovieModel?

    func outputData(with json : JSON?) {
        
        if let json = json{
            let movieModel = interactor?.detailWorker?.parseData(json: json, for: movie!)
            view?.showData(model: movieModel)
        }else{
            view?.showData(model: movie!)
        }
        
        view?.hideAI()
        
    }
    
    
    func presentData(with model: MovieModel?) {
        view?.showAI()
        movie = model
        let url = "https://api.themoviedb.org/3/movie/\(model!.id)?api_key=\(API_KEY)&language=en-US"
        interactor?.fetchDetail(with: url)

    }
    
    
    
    
    
    
}


