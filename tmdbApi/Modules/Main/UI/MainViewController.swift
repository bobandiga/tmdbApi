//
//  ViewController.swift
//  tmdbApi
//
//  Created by air on 2/21/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

var first = true

class MainViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter : MainPresenterProtocol!
    var builder : MainBuilderProtocol! = MainBuilder()
    
    var collectionViewCellModelArray = [MovieModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        builder.assembleModule(view: self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width / 4 - 2, height: width / 2)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        collectionView.collectionViewLayout = layout
        
        if first{
            presenter.presentData(with: URLString.url(language: .en), urlType: .popular)
            first = false
        }
        
    
    }

    @IBAction func menuBtnHandle(_ sender: UIButton) {
        presenter.wireframe?.presentMenu()
        
    }
    
    @IBAction func loadMoreHandle(_ sender: UIButton) {
        
    }
    
}

extension MainViewController: MainViewControllerProtocol{
    
    func showAI() {
        showProgressIndicator(view: self.view)
    }
    
    func hideAI() {
        hideProgressIndicator(view: self.view)
    }
    
    
    func updateLable(with text: String) {
        categoryLabel.text = text
    }
    
    
    func updateData(array: [MovieModel]) {
        for model in array{
            self.collectionViewCellModelArray.append(model)
        }
        self.collectionView.reloadData()
    }
    
    
    func showData(array: [MovieModel]) {
        //print("show data \(array.count)")
        self.collectionViewCellModelArray = array
        self.collectionView.reloadData()
    }
    
    func showError() {
        print("error")
    }
    
}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.setup(with: collectionViewCellModelArray[indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.wireframe?.presentDetailViewController(with: collectionViewCellModelArray[indexPath.item])
    }
    
    
}



