//
//  LandingController.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/7/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit
import AVFoundation

class LandingViewController: UIViewController {
    
    
    // Creating Audio Player
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
    
    
    // Bringing in elements from the view
    @IBOutlet weak var StartText: UIView!
    @IBOutlet weak var Sprite: UIImageView!
    
    
    // creating audio player function
    func playBackgroundMusic(filename: String) {
        let url = Bundle.main.url(forAuxiliaryExecutable: filename)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: newURL)
            audioPlayer?.numberOfLoops = 5
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch let error as NSError {
            print(error.description)
        }
    }

    
    
    // view did load function
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // creating animation function for image
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0.5
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = FLT_MAX
        
        
        
       // applying animation to sprite picture
        Sprite.layer.add(pulseAnimation, forKey: nil)
        
        
        //play music
        
        playBackgroundMusic(filename:"TitleMusic.mp3")
        
        // setting the background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at:0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    @IBAction func TouchScreen(_ sender: Any) {
         self.performSegue(withIdentifier: "showGame", sender: sender)
        print("TOUCHED")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
