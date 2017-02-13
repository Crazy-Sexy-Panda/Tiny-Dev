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

    let background = SKSpriteNode(imageNamed: "bedroom4.png")
    
     override func didMove(to view: SKView) {
        
        //setting background behind dev
        background.zPosition = 1
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        addChild(background)
        
        //getting multiple png files to animate dev
        let f0 = SKTexture.init(imageNamed: "idledev1.png")
        let f1 = SKTexture.init(imageNamed: "idledev2.png")
        let f2 = SKTexture.init(imageNamed: "idledev3.png")
        let f3 = SKTexture.init(imageNamed: "idledev4.png")
        let frames: [SKTexture] = [f0, f1, f2, f3]
        
        //initial dev position
        TinyDev.position = CGPoint(x: size.width * 0.5, y: size.height * 0.19)
        TinyDev.zPosition = 2
        
        //using the sktexture variables in array frames to animate dev.
        let animation = SKAction.animate(with: frames, timePerFrame: 0.2)
        TinyDev.run(SKAction.repeatForever(animation))
        
        addChild(TinyDev)
        
        //move dev back and forth
        let actionMove = SKAction.move(to: CGPoint(x: size.width * 0.2, y: size.height * 0.19), duration: TimeInterval(1.0))
        let actionBack = SKAction.move(to: CGPoint(x: size.width * 0.8, y: size.height * 0.19), duration: TimeInterval(1.0))
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
