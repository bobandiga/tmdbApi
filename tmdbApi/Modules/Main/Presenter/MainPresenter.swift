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
    
    func outputData(json: [MovieModel]) {
        print("output data")
        view?.showData(array: json)
        view?.hideAI()

    }
    
    func presentData(with url: String, urlType : URLType) {
        print("present data")
        view?.showAI()
        interactor?.fetchData(with: url, urlType: urlType)
    }
    
}

