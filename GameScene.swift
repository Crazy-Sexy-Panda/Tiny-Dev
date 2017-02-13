//
//  GameScene.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/13/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit
import SpriteKit


class GameScene: SKScene {
    
    let TinyDev = DevImage()

    
     override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        TinyDev.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        addChild(TinyDev)
        
        let actionMove = SKAction.move(to: CGPoint(x: size.width * 0.8, y: size.height * 0.3), duration: TimeInterval(3.0))
        let actionBack = SKAction.move(to: CGPoint(x: size.width * 0.9, y: size.height * 0.5), duration: TimeInterval(3.0))
        let actions = SKAction.repeatForever((SKAction.sequence([actionMove, actionBack])))
        TinyDev.run(actions)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            let positionInScene = touch?.location(in: self)
            let touchedNode = self.atPoint(positionInScene!)
            
            if let name = touchedNode.name
            {
                if name == "DevImage"
                {
                    print("Touched")
                }
            }
        
    }

}
