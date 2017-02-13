//
//  DevImage.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/13/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class DevImage: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
        
        
    }

    func playIdleAnimation() {
        print("The Init Animation Function is Running")
        self.image = UIImage(named: "idledev1.png")
    
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        for x in 1...4 {
            let img = UIImage(named: "idledev\(x).png")
            imageArray.append(img!)
        }
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        UIView.animateWithDuration(0.5, delay: 0.3, animations: {
            self.imageView.center.y += self.view.bounds.height
        }, completion: nil)
        
//        let actionMove = self.move(to: CGPoint(x: 0.8, y: 0.3), duration: TimeInterval(3.0))
//        let actionBack = self.move(to: CGPoint(x: size.width * 0.9, y: size.height * 0.5), duration: TimeInterval(3.0))
//        let actions = SKAction.repeatForever((SKAction.sequence([actionMove, actionBack])))
        
        
        
        self.startAnimating()
        
        
        
        
    }
    
}
