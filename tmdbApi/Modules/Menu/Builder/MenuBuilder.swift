//
//  MenuBuilder.swift
//  tmdbApi
//
//  Created by air on 3/7/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation

import UIKit

class MenuBuilder : MenuBuilderProtocol{
    
    func assembleModule(view: MenuViewController) {
        let presenter = MenuPresenter()
        let interactor = MenuInteractor()
        let wireframe = MenuWireframe()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        presenter.view = view
        
        wireframe.viewController = view
    }
    
    
}

