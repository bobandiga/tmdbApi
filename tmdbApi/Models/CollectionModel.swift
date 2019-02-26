//
//  CollectionView.swift
//  tmdbApi
//
//  Created by air on 2/21/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

class CollectionModel: NSObject {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var forAIView: UIView!
    
    var collectionViewCellModelArray = [MovieModel]()
    
    private var service = Service()

    func fetchData(block : @escaping () -> ()){
        
        service.fetch(activityIndicator: activityIndicator, r: request, { (movies) in
            if let movies = movies{
                self.collectionViewCellModelArray = movies
                block()
            }
        })
    }
    
    lazy var activityIndicator : ActivityIndicator = {
        let ai = ActivityIndicator(style: .whiteLarge, view: forAIView)
        return ai
    }()
    
    func reloadData(){
        collectionView.reloadData()
    }
    
    func setupCollectionView(){
        
        collectionViewCellModelArray = []
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width / 4 - 2, height: width / 2)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        collectionView.collectionViewLayout = layout
        
        
    }
    
    enum CurrentView : String {
        case popular = "popular"
        case topRated = "top_rated"
        case upcoming = "upcoming"
    }
    
    var currentView = CurrentView.popular{
        willSet(new){
            if new == .popular{
                request = Service.Request.popular
                titleLabel.text! = "Popular"
            }
            if new == .topRated{
                request = Service.Request.topRated
                titleLabel.text! = "Top rated"
            }
            if new == .upcoming{
                request = Service.Request.upcoming
                titleLabel.text! = "Upcoming"
            }
            
        }
    }
    
    
    
    var request = Service.Request.popular
    
    @IBAction func loadMoreHandle(_ sender : LoadbuttonModel){
        
        sender.isUserInteractionEnabled = false
        
        collectionViewCellModelArray = []
        collectionView.isUserInteractionEnabled = false
        
        sender.request(activityIndicator: activityIndicator, request, increas: true, block: { (movies) in
            if let movies = movies{
                for m in movies{
                    self.collectionViewCellModelArray.append(m)
                }
            }
        }) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                if !self.collectionViewCellModelArray.isEmpty{
                    DispatchQueue.main.async {
                        self.collectionView.scrollToItem(at: IndexPath(item: self.collectionViewCellModelArray.count - 1, section: 0), at: .bottom, animated: true)
                    }
                    
                }
            }
            sender.isUserInteractionEnabled = true
            self.collectionView.isUserInteractionEnabled = true
        }
    }
    
}

extension CollectionModel : UICollectionViewDelegate{
    
}

extension CollectionModel : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.setup(with: collectionViewCellModelArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController        
        
        service.fetchDetails(activityIndicator: activityIndicator, movieId: collectionViewCellModelArray[indexPath.item].id, { (genres,companies)  in
            if let genres = genres, let companies = companies {
                self.collectionViewCellModelArray[indexPath.item].genres = genres
                self.collectionViewCellModelArray[indexPath.item].companies = companies
            }
            
        }) {
            nextViewController.movie = self.collectionViewCellModelArray[indexPath.item]
            UIApplication.shared.keyWindow?.rootViewController?.present(nextViewController, animated: true, completion: nil)
        }
        
        
    }
    
}
