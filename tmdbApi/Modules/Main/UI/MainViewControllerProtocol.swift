//
//  MainViewControllerProtocol.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation

protocol MainViewControllerProtocol : class{
    
    func showData(array : [MovieModel])
    func updateLable(with text : String)
    func updateData(array : [MovieModel])
    func showError()
    func showAI()
    func hideAI()
    
}

