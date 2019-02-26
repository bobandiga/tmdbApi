//
//  LoadMoreDutton.swift
//  tmdbApi
//
//  Created by air on 2/23/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

class LoadbuttonModel: UIButton {

    private var popularPage : Int{
        get{
            return UserDefaults.standard.integer(forKey: "popularPage")
        }
        set(new){
            UserDefaults.standard.set(new, forKey: "popularPage")
        }
    }
    private var topRated : Int{
        get{
            return UserDefaults.standard.integer(forKey: "topRatedPage")
        }
        set(new){
            UserDefaults.standard.set(new, forKey: "topRatedPage")
        }
    }
    private var upComing : Int{
        get{
            return UserDefaults.standard.integer(forKey: "upcomingPage")
        }
        set(new){
            UserDefaults.standard.set(new, forKey: "upcomingPage")
        }
    }
    
    private var service = Service()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func request(activityIndicator : ActivityIndicator, _ request : Service.Request,  increas : Bool, block : @escaping ([MovieModel]?) -> (), finished : @escaping () -> ()){
        
        var arrMovies : [MovieModel]? = []

        var pp = 0
        
        if increas{
            switch request {
            case .popular:
                popularPage += 1
                break
            case .topRated:
                topRated += 1
                break
            case .upcoming:
                upComing += 1
                break
            }
        }
        
        switch request {
        case .popular:
            pp = popularPage
            break
        case .topRated:
            pp = topRated
            break
        case .upcoming:
            pp = upComing
            break
        }
        
        print("popular : \(popularPage)")
        print("top rated : \(topRated)")
        print("upcoming : \(upComing)")
        
        if increas{
            service.fetch(activityIndicator: activityIndicator, r: request, page: pp, { (movies) in
                arrMovies = movies
                block(arrMovies)
                finished()
            }, nil)
        }else{
            for p in 1...pp{
                service.fetch(activityIndicator: activityIndicator, r: request, page: p, { (movies) in
                    if let movies = movies{
                        for m in movies{
                            arrMovies?.append(m)
                        }
                    }
                    //print(arrMovies)
                    if p == pp{
                        block(arrMovies)
                        finished()
                    }
                    
                }, {
                    
                })
            }
        }
        
    }

}
