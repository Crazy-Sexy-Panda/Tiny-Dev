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

class DevImage: SKSpriteNode {
   
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    convenience init() {
        self.init(imageNamed:"idledev1.png")
        self.name = "DevImage"

    }
    
    override init(texture: SKTexture!, color: (UIColor!), size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

   
 
   
}






