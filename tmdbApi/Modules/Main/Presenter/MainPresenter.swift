//
//  MainPresenter.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import SwiftyJSON

class MainPresenter: MainPresenterProtocol {
    
    weak var view : MainViewControllerProtocol?
    var wireframe: MainWireframeProtocol?
    var interactor: MainInteractorProtocol?
    
    func outputData(json: [MovieModel], append : Bool) {
        print("output data")
        
        if json.isEmpty{
            view?.showError()
        }
        
        if append{
            view?.updateData(array: json)
        }else{
            view?.showData(array: json)
        }
        
        view?.hideAI()

    }
    
    func presentData(with url: String) {
        print("present data")
        self.view?.showAI()
        interactor?.fetchData(with: url)
    }
    
}

