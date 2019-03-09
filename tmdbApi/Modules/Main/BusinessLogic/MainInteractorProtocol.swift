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
    
    func fetchData(with url : String)
    func fetchImage(for models : [MovieModel]?, _ block : @escaping ([MovieModel]) -> ())
    
    func fetchDataFromLoadButton(with url : String)
    func fetchDataFromMenuButton(with url : String, urlType : URLType)
    func fetchData(with url : String, urlType : URLType)
    
}

