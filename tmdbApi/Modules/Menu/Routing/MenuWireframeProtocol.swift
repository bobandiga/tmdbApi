//
//  MenuWireframeProtocol.swift
//  tmdbApi
//
//  Created by air on 3/7/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit

protocol MenuWireframeProtocol {
    
    var viewController : UIViewController? {get}
    
    func dismiss(with url : String, title : String)
    
    func showAI()
    
}


