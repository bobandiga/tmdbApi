//
//  ViewController.swift
//  tmdbApi
//
//  Created by air on 2/21/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionModel: CollectionModel!
    @IBOutlet var menuModel: MenuModel!
    
    override func viewWillAppear(_ animated: Bool) {
        URLCache.shared.removeAllCachedResponses()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionModel.setupCollectionView()
        collectionModel.fetchData {
            DispatchQueue.main.async {
                self.collectionModel.reloadData()
                //print(URLCache.shared.currentMemoryUsage)
            }
            
        }
        
    }


}

