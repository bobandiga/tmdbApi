//
//  MenuViewController.swift
//  tmdbApi
//
//  Created by air on 3/7/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController : UIViewController{
    
    var presenter : MenuPresenterProtocol!
    var builder : MenuBuilderProtocol? = MenuBuilder()
    
    let identifier = "MenuToMain"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        builder?.assembleModule(view: self)
        
    }
    
    @IBAction func popularHandle(_ sender: UIButton) {
        
        presenter?.wireframe?.dismiss(with: URLString.url(with: .popular, language: .en), title: (sender.titleLabel?.text)!)
    }
    
    @IBAction func topratedHndle(_ sender: UIButton) {
        presenter?.wireframe?.dismiss(with: URLString.url(with: .top_rated, language: .en), title: (sender.titleLabel?.text)!)
    }
    
    @IBAction func upcomingHandle(_ sender: UIButton) {
        presenter?.wireframe?.dismiss(with: URLString.url(with: .upcoming, language: .en), title: (sender.titleLabel?.text)!)
    }
    
}

extension MenuViewController : MenuViewControllerProtocol {
    
}

