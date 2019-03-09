//
//  DetailWorker.swift
//  tmdbApi
//
//  Created by air on 3/9/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import SwiftyJSON

class DetailWorker : Worker{
    
    override func fetchData(with url: String, _ block: @escaping (JSON?) -> ()){
        super.fetchData(with: url) { (json) in
            block(json)
        }
    }
    
    func parseData(json : JSON?, for movie :  MovieModel) -> MovieModel{
        let array = super.parseData(with: json, parseType: .movieDetail) as! [[String]]
        
        let mm = MovieModel(id: movie.id, title: movie.title, originalTitle: movie.originalTitle, posterImage: movie.posterImage, imagePath: movie.imagePath, releaseDate: movie.releaseDate, voteAvarage: movie.voteAvarage, overview: movie.overview, genres: array[0], companies: array[1])
        
        return movie
    }
    
}
