//
//  MainInteractorProtocol.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation

protocol MainInteractorProtocol {
    
    var mainWorker : MainWorker? {get}
    
    var presenter : MainPresenterProtocol? {get set}
    
    //func fetchImage(for models : [MovieModel]?, _ block : @escaping ([MovieModel]) -> ())
    
    func fetchData(with url : String)
    
}

