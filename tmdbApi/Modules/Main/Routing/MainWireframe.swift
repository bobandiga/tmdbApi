//
//  MainWireFrame.swift
//  tmdbApi
//
//  Created by air on 3/5/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit

class MainWireframe: MainWireframeProtocol {
    
    func presentMenu() {
        print("present menu")
        let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        viewController?.present(mvc!, animated: true, completion: nil)
    }
    
    func presentDetailViewController(with movie : MovieModel) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController")  as? DetailViewController
        viewController?.present(detailVC!, animated: true, completion: nil)
        detailVC?.presenter.presentData(with: movie)
    }
    
    weak var viewController : UIViewController?
    
    
}
