//
//  MenuPresenter.swift
//  tmdbApi
//
//  Created by air on 3/7/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation

class MenuPresenter: MenuPresenterProtocol {
    
    weak var view: MenuViewControllerProtocol?
    var interactor: MenuInteractorProtocol?
    var wireframe: MenuWireframeProtocol?
    
    
}
