//
//  MenuPresenterProtocol.swift
//  tmdbApi
//
//  Created by air on 3/7/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation

protocol MenuPresenterProtocol {
    
    var view : MenuViewControllerProtocol? {get}
    var interactor : MenuInteractorProtocol? {get}
    var wireframe : MenuWireframeProtocol? {get}
    
}
