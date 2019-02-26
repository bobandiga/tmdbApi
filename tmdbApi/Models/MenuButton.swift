//
//  MenuButton.swift
//  tmdbApi
//
//  Created by air on 2/22/19.
//  Copyright © 2019 Maxilimon. All rights reserved.
//

import UIKit

class MenuButton: UIButton {

    private var flag = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func dropDown(view : UIView){
        
        if flag{
            hideAnimate(view: view)
        }else{
            openAnimate(view: view)
        }
        flag = !flag
    }
    
    func openAnimate(view: UIView){
        
        view.isHidden = false
        view.transform = CGAffineTransform.init(translationX: -view.frame.width, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform.init(translationX: 0 - 2, y: 0)
        }, completion: {(finished) in
            
        })
        
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
            self.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
        }, completion: nil)
    }
    
    func hideAnimate(view: UIView){
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform.init(translationX: -view.frame.width - 2, y: 0)
        }, completion: {(finished) in
            view.isHidden = true
        })
        
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
            self.transform = CGAffineTransform.init(rotationAngle: 0)
        }, completion: nil)
    }

}

