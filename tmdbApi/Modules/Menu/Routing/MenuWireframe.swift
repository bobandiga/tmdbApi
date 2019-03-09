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
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuToMain"{
            print("SEQUEEEE")
            let mainVC = segue.destination as! MainViewController
            mainVC.presenter.presentData(with: "", urlType: .popular)
        }
    }
    
    
    func showAI() {
        
    }
    
    var viewController: UIViewController?
    
    func dismiss(with url: String, title : String, urlType : URLType) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        viewController?.present(vc!, animated: true, completion: nil)
        vc?.presenter.presentData(with: url, urlType: urlType)
        vc?.presenter.view?.updateLable(with: title)
    }
    
    

}

