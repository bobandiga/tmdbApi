//
//  DetailWireframe.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit

class DetailWireframe: DetailWireframeProtocol {
    
    weak var viewController : UIViewController?
    
    func dismissViewController() {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
//        vc?.builder.assembleModule(view: vc!)
        viewController?.dismiss(animated: true, completion: nil)
    }
    
}
