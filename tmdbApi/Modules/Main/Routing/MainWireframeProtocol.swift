//
//  MainWireframeProtocol.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit

protocol MainWireframeProtocol {
    
    var viewController : UIViewController? { get }
    
    func presentDetailViewController(with movie : MovieModel)
    
    func presentMenu()
    
    
}

protocol MainChangeDataProtocol {
    
    func changeData()
    
}
