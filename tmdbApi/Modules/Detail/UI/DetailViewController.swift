//
//  DetailViewController.swift
//  tmdbApi
//
//  Created by air on 2/24/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var presenter : DetailPresenterProtocol!
    var builder : DetailBuilderProtocol! = DetailBuilder()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overViewTF: UITextView!
    @IBOutlet weak var voteAvarageLabel: UILabel!
    @IBOutlet weak var companiesLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    private var model : MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        builder.assembleModule(view: self)
    }
    
    @IBAction func back(){
        presenter.wireframe?.dismissViewController()
    }

}


extension DetailViewController: DetailViewControllerProtocol{
    
    func showAI() {
        showProgressIndicator(view: self.view)
    }
    
    func hideAI() {
        hideProgressIndicator(view: self.view)
    }
    
    
    func setupUI() {
        titlelabel.text = model?.title
        originalTitleLabel.text = model?.originalTitle
        dateLabel.text = model?.releaseDate
        overViewTF.text = model?.overview
        voteAvarageLabel.text = model?.voteAvarage
        companiesLabel.text = model?.companies
        genresLabel.text = model?.genres
    }
    
    
    func showData(model: MovieModel?) {
        self.model = model
        setupUI()
    }
    
    func showError() {
        print("error")
    }
    
    
    
    
}
