//
//  DetailViewControllerProtocol.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation

protocol DetailViewControllerProtocol : class {
    
    func showData(model : MovieModel?)
    func setupUI()
    func showError()
    
    func showAI()
    func hideAI()
    
}
