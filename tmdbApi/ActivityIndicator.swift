//
//  A.swift
//  tmdbApi
//
//  Created by air on 2/23/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView{

    private var loadingView: UIView!
    private var bckgView: UIView!
    
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        
    }
    
    convenience init(style : UIActivityIndicatorView.Style, view : UIView) {
        self.init(style: style)
        self.bckgView = view
        addIndicatorTo()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addIndicatorTo(){
        
        loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        loadingView.center = bckgView.center
        loadingView.backgroundColor = UIColor(rgb: 0x444444).withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        self.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(self)
        bckgView.addSubview(loadingView)
        loadingView.center = CGPoint(x: bckgView.bounds.width / 2, y: bckgView.bounds.height / 2)
    }
    
    override func startAnimating() {
        bckgView.isHidden = false
        loadingView.isHidden = false
        super.startAnimating()
    }
    
    override func stopAnimating() {
        super.stopAnimating()
        loadingView.isHidden = true
        bckgView.isHidden = true
    }
    
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
