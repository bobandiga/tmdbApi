//
//  DetailInteractorProtocol.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation

protocol DetailInteractorProtocol {
 
    var presenter : DetailPresenterProtocol? {get}
    var detailWorker : DetailWorker? {get}
    
    func fetchDetail(with url : String)
    
}
