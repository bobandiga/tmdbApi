//
//  DetailWireframeProtocol.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit

protocol DetailWireframeProtocol {
    
    var viewController : UIViewController? { get }
    
    func dismissViewController()
    
}
