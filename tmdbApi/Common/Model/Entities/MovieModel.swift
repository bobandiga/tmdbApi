//
//  CollectionViewCellModel.swift
//  tmdbApi
//
//  Created by air on 2/23/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

struct MovieModel {
    
    var id : String
    var title : String
    var originalTitle : String
    var posterImage : UIImage?
    var releaseDate : String
    var voteAvarage : String
    var overview : String
    var genres : String = ""
    var companies : String = ""
    var imagePath : URL
    
    init(id : String, title : String, originalTitle : String, posterImage : UIImage?, imagePath : URL, releaseDate : String, voteAvarage : String, overview : String, genres : [String], companies : [String]) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.posterImage = posterImage ?? UIImage(named: "question")
        self.releaseDate = releaseDate
        self.voteAvarage = voteAvarage
        self.overview = overview
        self.imagePath = imagePath
        
        for genre in genres{
            self.genres.append(genre + " ")
        }
        
        for company in companies{
            self.companies.append(company + " ")
        }
    }
    
}
