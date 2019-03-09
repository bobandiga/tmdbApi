//
//  DetailInteractor.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class DetailInteractor : DetailInteractorProtocol{
    
    var presenter: DetailPresenterProtocol?
    
    func fetchDetail(with url: String) {
        detailWorker?.fetchData(with: url, { (json) in
            self.presenter?.outputData(with: json)
        })
    }
    
    var detailWorker: DetailWorker?
    
    
}
