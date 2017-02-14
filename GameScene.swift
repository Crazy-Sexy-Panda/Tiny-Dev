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
    var progressView: UIProgressView?
    var progressLabel: UILabel?

    let background = SKSpriteNode(imageNamed: "bedroom4.png")
    var movableNode : Item?
    
    var initialPositionPing: CGPoint?
    var initialPositionBeer: CGPoint?
    var initialPositionCode: CGPoint?
    var Opaque:CGFloat = 1
    var Dim_Alpha:CGFloat = 0.5
    var customTimer: Timer?
    var counter = 0
    var itemArray:Array<Item> = []
    var randomIndex:Int?
    
    let ping = Item(imageNamed: "ping.png")
    let beer = Item(imageNamed: "beer.png")
    let code = Item(imageNamed: "code.png")
    
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
       
        ping.position = initialPositionPing!
        ping.name = "ping"
        ping.size = CGSize(width: 100, height: 100)
        ping.zPosition = 3
        ping.alpha = Dim_Alpha
        addChild(ping)
        
        //beer stuff
        
        beer.position = initialPositionBeer!
        beer.name = "beer"
        beer.size = CGSize(width: 100, height: 100)
        beer.zPosition = 3
        beer.alpha = Dim_Alpha
        addChild(beer)
        
        //code stuff
        
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
            if (name == "ping" && ping.active == true) {
                movableNode = childNode(withName: "ping") as! SKSpriteNode? as! GameScene.Item?
                movableNode?.alpha = Opaque
            } else if (name == "beer" && beer.active == true) {
                movableNode = childNode(withName: "beer") as! SKSpriteNode? as! GameScene.Item?
                movableNode?.alpha = Opaque
            } else if (name == "code" && code.active == true) {
                movableNode = childNode(withName: "code") as! SKSpriteNode? as! GameScene.Item?
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
                        movableNode?.alpha = Dim_Alpha
                        movableNode?.active = false
                        movableNode = nil
                    } else if (movableNode?.name == "beer") {
                        movableNode!.position = initialPositionBeer!
                        movableNode?.alpha = Dim_Alpha
                        movableNode?.active = false
                        movableNode = nil
                    } else if (movableNode?.name == "code") {
                        movableNode!.position = initialPositionCode!
                        movableNode?.alpha = Dim_Alpha
                        movableNode?.active = false
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
        print(counter%2)
        selectAndActivate()
    }
    
    func selectAndActivate() {
        print(counter%5)
        if(counter%5==0) {
            
                if (itemArray[0].active == false || itemArray[1].active == false || itemArray[2].active == false) {
                    
                    var activeItem = itemArray.sample()
                    while (activeItem.active == true) {
                        activeItem = itemArray.sample()
                    }
                    print(activeItem)
                    activeItem.active = true
                    activeItem.alpha = Opaque
                }
            
          
        }
    }
    
    class Item: SKSpriteNode {
        var active = false
        
    
    
    }

    
    
    
        }

extension Array {
    func sample() -> Element {
        let randomIndex = Int(arc4random()) % count
        return self[randomIndex]
    }
}





