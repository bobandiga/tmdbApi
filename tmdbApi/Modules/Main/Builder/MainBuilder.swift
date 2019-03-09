//
//  MainBuilder.swift
//  tmdbApi
//
//  Created by air on 3/6/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation

import UIKit

class MainBuilder : MainBuilderProtocol{
    
    func assembleModule(view: MainViewController) {
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let wireframe = MainWireframe()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        presenter.view = view
        
        wireframe.viewController = view
        
        let worker = MainWorker()
        
        interactor.mainWorker = worker
        interactor.presenter = presenter
    }
    
}




