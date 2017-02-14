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
    var movableNode : SKSpriteNode?
    
    var initialPositionPing: CGPoint?
    var initialPositionBeer: CGPoint?
    var initialPositionCode: CGPoint?
    var Opaque:CGFloat = 1
    var Dim_Alpha:CGFloat = 0.5
    var customTimer: Timer?
    var counter = 0
    var itemArray:Array<SKSpriteNode>?
    var randomIndex:Int?
     override func didMove(to view: SKView) {
        initialPositionPing = CGPoint(x:frame.size.width/6,  y:573.5)
        initialPositionBeer = CGPoint(x:frame.size.width/2,  y:573.5)
        initialPositionCode = CGPoint(x:frame.size.width / 1.25,  y:573.5)

        
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
        
        //ping stuff
        let ping = SKSpriteNode(imageNamed: "ping.png")
        ping.position = initialPositionPing!
        ping.name = "ping"
        ping.size = CGSize(width: 100, height: 100)
        ping.zPosition = 3
        ping.alpha = Dim_Alpha
        addChild(ping)
        
        //beer stuff
        let beer = SKSpriteNode(imageNamed: "beer.png")
        beer.position = initialPositionBeer!
        beer.name = "beer"
        beer.size = CGSize(width: 100, height: 100)
        beer.zPosition = 3
        beer.alpha = Dim_Alpha
        addChild(beer)
        
        //code stuff
        let code = SKSpriteNode(imageNamed: "code.png")
        code.position = initialPositionCode!
        code.name = "code"
        code.size = CGSize(width: 100, height: 100)
        code.zPosition = 3
        code.alpha = Dim_Alpha
        addChild(code)
        
        //create item array
        itemArray = [ping,beer,code]
        // randomIndex = Int(arc4random_uniform(UInt32((self.count)!)))
        //Time Functions 
        updateCounter()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            let positionInScene = touch?.location(in: self)
            let touchedNode = self.atPoint(positionInScene!)
            
        if var name = touchedNode.name
        {
            if name == "ping" {
                movableNode = childNode(withName: "ping") as! SKSpriteNode?
                movableNode?.alpha = Opaque
            } else if name == "beer" {
                movableNode = childNode(withName: "beer") as! SKSpriteNode?
                movableNode?.alpha = Opaque
            } else if name == "code" {
                movableNode = childNode(withName: "code") as! SKSpriteNode?
                movableNode?.alpha = Opaque
            }

        }
            }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first, movableNode != nil {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
                if (movableNode?.intersects(TinyDev))!{
                    movableNode?.alpha = Dim_Alpha
                    print("PRINTING FOR REAL")
                    if (movableNode?.name == "ping"){
                        movableNode!.position = initialPositionPing!
                        movableNode = nil
                    } else if (movableNode?.name == "beer") {
                        movableNode!.position = initialPositionBeer!
                        movableNode = nil
                    } else if (movableNode?.name == "code") {
                        movableNode!.position = initialPositionCode!
                        movableNode = nil
                    }
                } else {
            movableNode!.position = touch.location(in: self)
            movableNode = nil
            }
        }
    }
    
    
    func updateCounter() {
        if (customTimer == nil) {
            customTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
        counter += 1
        let time: String = "\(counter) seconds have passed"
        print(time) //for the console
        print(itemArray?.sample())
        
    }
    
        }


extension Array {
    func sample() -> Element {
        let randomIndex = Int(arc4random()) % count
        return self[randomIndex]
    }
}
