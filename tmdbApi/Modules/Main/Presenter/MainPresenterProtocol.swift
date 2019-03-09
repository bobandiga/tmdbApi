//
//  MainPresenterProtocol.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol MainPresenterProtocol {
    
    var view : MainViewControllerProtocol? {get}
    var wireframe : MainWireframeProtocol? {get}
    var interactor : MainInteractorProtocol? {get}
    
    func presentData(with url : String, urlType : URLType)
    func outputData(json : [MovieModel])
    
}

