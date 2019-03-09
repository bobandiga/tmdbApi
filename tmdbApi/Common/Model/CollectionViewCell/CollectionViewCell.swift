//
//  CollectionViewCell.swift
//  tmdbApi
//
//  Created by air on 2/21/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

protocol CollectionViewCellSetup {
    func setup(with model : MovieModel)
}

class CollectionViewCell: UICollectionViewCell, CollectionViewCellSetup{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    func setup(with model : MovieModel){
        
//        titleLabel.layer.borderColor = UIColor.white.cgColor
//        titleLabel.layer.borderWidth = 0.5
        titleLabel.backgroundColor = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 0.7018942637)
        imageView.image = model.posterImage ?? UIImage(named: "question")
        titleLabel.text = model.title
    }

}

