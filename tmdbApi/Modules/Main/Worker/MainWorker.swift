//
//  MainWorker.swift
//  tmdbApi
//
//  Created by air on 3/8/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import SwiftyJSON

class MainWorker : Worker{
    
    override func fetchData(with url: String, _ block: @escaping (JSON?) -> ()){
        super.fetchData(with: url) { (json) in
            block(json)
        }
    }
    
    func parseData(json : JSON?) -> [MovieModel]{
        return super.parseData(with: json, parseType: .movies) as! [MovieModel]
    }
    
}
