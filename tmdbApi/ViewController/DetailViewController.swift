//
//  DetailViewController.swift
//  tmdbApi
//
//  Created by air on 2/24/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var movie : MovieModel!
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    
    @IBOutlet weak var titlelabel: UILabel!
    var title1 = ""
    
    @IBOutlet weak var originalTitleLabel: UILabel!
    var originalTitle = ""
    
    @IBOutlet weak var dateLabel: UILabel!
    var date = ""
    
    @IBOutlet weak var overViewTF: UITextView!
    var overview = ""
    
    @IBOutlet weak var voteAvarageLabel: UILabel!
    var voteAvarage = ""
    
    @IBOutlet weak var companiesLabel: UILabel!
    var companies = ""
    
    @IBOutlet weak var genresLabel: UILabel!
    var genres = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie{
            image = movie.posterImage
            title1 = movie.title
            originalTitle = movie.originalTitle
            date = movie.releaseDate
            overview = movie.overview
            voteAvarage = movie.voteAvarage
            
            if !movie.companies.isEmpty{
                for (index,c) in movie.companies.enumerated(){
                    companies.append("\(c)")
                    if index == movie.companies.count - 1{
                        
                    }else{
                        companies.append(", ")
                    }
                    
                }
            }else{
                companies = "-"
            }
            
            if !movie.genres.isEmpty{
                for (index,g) in movie.genres.enumerated(){
                    genres.append("\(g)")
                    if index == movie.genres.count - 1{
                        
                    }else{
                        genres.append(", ")
                    }
                }
            }else{
                genres = "-"
            }
            
            imageView.image = image
            titlelabel.text = title1
            originalTitleLabel.text = originalTitle
            dateLabel.text = date
            voteAvarageLabel.text = voteAvarage
            companiesLabel.text = companies
            companiesLabel.sizeToFit()
            genresLabel.text = genres
            genresLabel.sizeToFit()
            overViewTF.text = overview
            overViewTF.isEditable = false
            
        }

    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
