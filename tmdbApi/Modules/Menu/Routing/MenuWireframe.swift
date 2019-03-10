//
//  MenuWireframe.swift
//  tmdbApi
//
//  Created by air on 3/7/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit

class MenuWireframe : MenuWireframeProtocol{
    
    func showAI() {
        
    }
    
    var viewController: UIViewController?
    
    func dismiss(with url: String, title : String) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        viewController?.present(vc!, animated: true, completion: {
            vc?.presenter.presentData(with: url)
            vc?.presenter.view?.updateLable(with: title)
        })
        
        
    }
    
    

}

