//
//  MenuView.swift
//  tmdbApi
//
//  Created by air on 2/22/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

class MenuModel: NSObject {

    @IBOutlet weak var collectionModel : CollectionModel!
    @IBOutlet weak var menuButton : MenuButton!
    @IBOutlet weak var dropView : UIView!
    
    @IBAction func buttonsHandle(_ sender: LoadbuttonModel) {
        
        DispatchQueue.main.async {
            self.menuButton.dropDown(view: self.dropView)
            
        }
        
        menuButton.isEnabled = false
        
        collectionModel.collectionViewCellModelArray = []
        
        if sender.tag == 0{
            collectionModel.currentView = .popular
        }
        if sender.tag == 1{
            collectionModel.currentView = .topRated
        }
        if sender.tag == 2{
            collectionModel.currentView = .upcoming
        }
        
        let request = collectionModel.request
        
        sender.request(activityIndicator: collectionModel.activityIndicator, request, increas: false, block: { (movies) in
            if let movies = movies{
                self.collectionModel.collectionViewCellModelArray = movies
            }
            
        }) {
            DispatchQueue.main.async {
                self.menuButton.isEnabled = true
                self.collectionModel.collectionView.reloadData()
                if !self.collectionModel.collectionViewCellModelArray.isEmpty{
                    self.collectionModel.collectionView.scrollToItem(at: IndexPath(item: self.collectionModel.collectionViewCellModelArray.count - 1, section: 0), at: .bottom, animated: true)
                    
                }
                self.collectionModel.collectionView.isUserInteractionEnabled = true
            }
        }
        
    }
    
    @IBAction func manuHandle(_ sender : MenuButton){
        collectionModel.collectionView.isUserInteractionEnabled = !collectionModel.collectionView.isUserInteractionEnabled
        sender.dropDown(view: dropView)
    }
    
}
