//
//  DetailBuilder.swift
//  tmdbApi
//
//  Created by air on 3/6/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit

class DetailBuilder : DetailBuilderProtocol{
    
    func assembleModule(view : DetailViewController){
        
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let wireframe = DetailWireframe()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        let worker = DetailWorker()
        
        interactor.detailWorker = worker
        interactor.presenter = presenter
        
        wireframe.viewController = view
        
    }
    
}
