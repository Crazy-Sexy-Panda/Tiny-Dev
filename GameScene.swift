//
//  GameScene.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/13/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


class GameScene: SKScene {
    var viewController: GameViewController!
    
    let TinyDev = DevImage()
    
    //sound effects
    
    var soundPlayer = AVAudioPlayer()
    var score:Int?
    let background = SKSpriteNode(imageNamed: "gameBG2.png")
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
    
    let level2 = SKSpriteNode(imageNamed: "level2.png")
    
    let ping = Item(imageNamed: "pinkpong.png")
    let beer = Item(imageNamed: "yellowpint.png")
    let code = Item(imageNamed: "greencom.png")
    let healthClear = SKSpriteNode(imageNamed: "bar.jpg")
    let healthFill = SKSpriteNode(imageNamed: "barFill.png")
    var healthLabel = SKLabelNode()
    var levelLabel = SKLabelNode()
    var num:CGFloat?
    
    let d0 = SKTexture.init(imageNamed: "dead1.png")
    let d1 = SKTexture.init(imageNamed: "dead2.png")
    let d2 = SKTexture.init(imageNamed: "dead3.png")
    let d3 = SKTexture.init(imageNamed: "dead4.png")
    let d4 = SKTexture.init(imageNamed: "dead5.png")
    
    let burstPath = Bundle.main.path(forResource: "pingSpark", ofType: "sks")
   
    
    
     override func didMove(to view: SKView) {
        initialPositionPing = CGPoint(x:frame.size.width/6,  y:570)
        initialPositionBeer = CGPoint(x:frame.size.width/2,  y:570)
        initialPositionCode = CGPoint(x:frame.size.width / 1.25,  y:570)

        //setting background behind dev
        background.zPosition = 1
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.size = self.frame.size
        
        addChild(background)
        
        //getting multiple png files to animate dev
        let f0 = SKTexture.init(imageNamed: "dev1.png")
        let f1 = SKTexture.init(imageNamed: "dev2.png")
        let f2 = SKTexture.init(imageNamed: "dev3.png")
        let f3 = SKTexture.init(imageNamed: "dev4.png")
        let frames: [SKTexture] = [f0, f1, f2, f3]
       
        
        //initial dev position
        TinyDev.position = CGPoint(x: size.width * 0.5, y: size.height * 0.22)
        TinyDev.zPosition = 2
        
        //using the sktexture variables in array frames to animate dev.
        let animation = SKAction.animate(with: frames, timePerFrame: 0.3)
        
        TinyDev.run(SKAction.repeatForever(animation))
        
        addChild(TinyDev)
        
        //move dev back and forth
        let actionMove = SKAction.move(to: CGPoint(x: size.width * 0.2, y: size.height * 0.22), duration: TimeInterval(1.0))
        let actionBack = SKAction.move(to: CGPoint(x: size.width * 0.8, y: size.height * 0.22), duration: TimeInterval(1.0))
        let actions = SKAction.repeatForever((SKAction.sequence([actionMove, actionBack])))
        TinyDev.run(actions)
        
        //ping stuff
       
        ping.position = initialPositionPing!
        ping.name = "ping"
        ping.size = CGSize(width: 90, height: 90)
        ping.zPosition = 3
        ping.alpha = Dim_Alpha
        addChild(ping)
        
        //beer stuff
        
        beer.position = initialPositionBeer!
        beer.name = "beer"
        beer.size = CGSize(width: 90, height: 90)
        beer.zPosition = 3
        beer.alpha = Dim_Alpha
        addChild(beer)
        
        //code stuff
        
        code.position = initialPositionCode!
        code.name = "code"
        code.size = CGSize(width: 90, height: 90)
        code.zPosition = 3
        code.alpha = Dim_Alpha
        addChild(code)
        
        //create Health Bar
        
        healthClear.position = CGPoint(x:frame.size.width/1.58,  y: 632)
        healthClear.zPosition = 7
        healthClear.size = CGSize(width:200, height: 20)
        addChild(healthClear)
        
        healthFill.position = CGPoint(x:frame.size.width/1.58,  y: 632)
        healthFill.zPosition = 7
        healthFill.size = CGSize(width:200, height: 20)
        addChild(healthFill)
        
        //Create Label
        
        healthLabel = SKLabelNode(fontNamed: "Arial")
        healthLabel.text = "Dev Health"
        healthLabel.fontSize = 20
        healthLabel.position = CGPoint(x:frame.size.width/5, y: 625)
        healthLabel.color = UIColor.white
        healthLabel.zPosition = 6
        self.addChild(healthLabel)
        
        //create level label
        levelLabel = SKLabelNode(fontNamed: "Arial")
        levelLabel.text = "Level One"
        levelLabel.fontSize = 20
        levelLabel.position = CGPoint(x:frame.size.width/2, y: 645)
        levelLabel.color = UIColor.white
        levelLabel.zPosition = 6
        self.addChild(levelLabel)
     
        
        //create item array
        itemArray = [ping,beer,code]
        // randomIndex = Int(arc4random_uniform(UInt32((self.count)!)))
        //Time Functions 
        updateCounter()
        
        //initialize health bar width
        num = healthFill.frame.size.width
        
        //set score
        score = 0
        
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            let positionInScene = touch?.location(in: self)
            let touchedNode = self.atPoint(positionInScene!)
        let burstNode = NSKeyedUnarchiver.unarchiveObject(withFile: burstPath!)
            as! SKEmitterNode
        
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
                    if (movableNode?.name == "ping"){
                        self.run(SKAction.playSoundFileNamed("PingSound.caf", waitForCompletion: true))
                        movableNode!.position = initialPositionPing!
                        movableNode?.alpha = Dim_Alpha
                        movableNode?.active = false
                        movableNode = nil
                        score = score! + 1
                        addHealth()
                    } else if (movableNode?.name == "beer") {
                        self.run(SKAction.playSoundFileNamed("Beer.mp3", waitForCompletion: true))
                        movableNode!.position = initialPositionBeer!
                        movableNode?.alpha = Dim_Alpha
                        movableNode?.active = false
                        movableNode = nil
                        score = score! + 1
                        addHealth()
                    } else if (movableNode?.name == "code") {
                        self.run(SKAction.playSoundFileNamed("Keyboard.mp3", waitForCompletion: true))
                        movableNode!.position = initialPositionCode!
                        movableNode?.alpha = Dim_Alpha
                        movableNode?.active = false
                        movableNode = nil
                        score = score! + 1
                        addHealth()
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
        selectAndActivate()
        changeLevel()
        checkIfAlive()
    }
    
    func selectAndActivate() {
        let burstNode = NSKeyedUnarchiver.unarchiveObject(withFile: burstPath!)
            as! SKEmitterNode
        if(counter%5==0) {
            
                if (itemArray[0].active == false || itemArray[1].active == false || itemArray[2].active == false) {
                    
                    var activeItem = itemArray.sample()
                    while (activeItem.active == true) {
                        activeItem = itemArray.sample()
                    }
                   
                    activeItem.active = true
                    activeItem.alpha = Opaque
                    burstNode.position = activeItem.position
                    self.addChild(burstNode)

                }

            
          
        }
    
    
    }
    
    func changeLevel() {
       
            print(counter)
            subtractHealth()
       if (counter > 10){
            print("level2")
            levelLabel.text = "Level Two"
            num = num! - 15.0
            healthFill.run(SKAction.resize(toWidth: num!, duration: 0))
        if (counter > 20) {
            print("level3")
            levelLabel.text = "Level Three"
            num = num! - 25.0
            healthFill.run(SKAction.resize(toWidth: num!, duration: 0))
        }
        
    }
    }
    
    
    func subtractHealth() {
        if num == nil {
        
        } else {
        num =  num! - 7.0
        
        healthFill.run(SKAction.resize(toWidth: num!, duration: 0))
        }
        
    }
    
    func addHealth() {
    
        num = num! + 50.0
        healthFill.run(SKAction.resize(toWidth: num!, duration: 0))
    
    }
    
    func checkIfAlive() {
        
        if(healthFill.frame.size.width <= 0) {
            let deadFrame: [SKTexture] = [d0,d1,d2,d3,d4]
            let deadAnimate = SKAction.animate(with: deadFrame, timePerFrame: 0.2)
            let dissapear = SKAction.removeFromParent()
            let sequence = SKAction.sequence([deadAnimate,dissapear])
            TinyDev.run(sequence)
            beer.removeFromParent()
            code.removeFromParent()
            ping.removeFromParent()
            healthLabel.removeFromParent()
            healthFill.removeFromParent()
            healthClear.removeFromParent()
        
            
            var timer = Timer()
            let delay = 3.0
            
            viewController.score = score
            timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
           
            
            }
    }
    
   
    
    class Item: SKSpriteNode {
        var active = false
        
    
    
    }


    func delayedAction() {
        beer.removeFromParent()
        code.removeFromParent()
        healthFill.removeFromParent()
        healthClear.removeFromParent()
        self.viewController.performSegue(withIdentifier: "showGameOver", sender: self)
    }
    
    
        }

extension Array {
    func sample() -> Element {
        let randomIndex = Int(arc4random()) % count
        return self[randomIndex]
    }
}




