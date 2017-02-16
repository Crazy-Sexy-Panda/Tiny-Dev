//
//  GameViewController.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/7/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
    
    var score:Int?
    
    
    // Get Shared Audio Player
    
    var audioPlayer : AVAudioPlayer? {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.audioPlayer
        }
        set {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.audioPlayer = newValue
        }
    }
    
    func stopBackgroundMusic(filename: String) {
        let url = Bundle.main.url(forAuxiliaryExecutable: filename)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: newURL)
            audioPlayer?.stop()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func playBackgroundMusic(filename: String) {
        let url = Bundle.main.url(forAuxiliaryExecutable: filename)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: newURL)
            audioPlayer?.numberOfLoops = 5
            audioPlayer?.volume = 0.2
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showGameOver"){
            //prepare for segue to the details view controller
            FirebaseManager.uploadScore(score: score!)
            let gameOverVC = segue.destination as!  GameOverViewController
            print(score)
            gameOverVC.score = score
            
            
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        stopBackgroundMusic(filename: "TitleMusic.mp3")
        playBackgroundMusic(filename: "gameMusic.mp3")
        let scene = GameScene(size:view.bounds.size)
        scene.viewController = self
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        scene.scaleMode = .resizeFill
        
    
        
        
        
        skView.presentScene(scene)
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
        
     
        
    }
        
        
    
}



