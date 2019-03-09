//
//  DetailPresenterProtocol.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol DetailPresenterProtocol {
    
    var view : DetailViewControllerProtocol? {get}
    var interactor : DetailInteractorProtocol? {get}
    var wireframe : DetailWireframeProtocol? {get}
    
    func presentData(with model : MovieModel?)
    func outputData(with json : JSON?)
    
    var movie : MovieModel? {get}
    
}
