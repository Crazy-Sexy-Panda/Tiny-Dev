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
    
    @IBOutlet var FunText: UILabel!
    
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
    
    var soundPlayer = AVAudioPlayer()
    
    // Bringing in elements from the view
    @IBOutlet weak var StartText: UIView!
    @IBOutlet weak var Sprite: UIImageView!
    @IBOutlet weak var devlogo: UIImageView!
    
    @IBOutlet weak var theButton: UIImageView!
       
    
    
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

    func playSoundEffect(filename: String) {
        let url = Bundle.main.url(forAuxiliaryExecutable: filename)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: newURL)
            soundPlayer.numberOfLoops = 1
            soundPlayer.prepareToPlay()
            soundPlayer.play()
            
        } catch let error as NSError {
            print(error.description)
        }
    }

    
    
    // view did load function
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
               
        // creating animation function for image
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 0.8
        pulseAnimation.fromValue = 0.3
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = FLT_MAX
        
        
        
       // applying animation to sprite picture
        
        theButton.layer.add(pulseAnimation, forKey: nil)
        
        
        //play music
        
        playBackgroundMusic(filename:"TitleMusic.mp3")
        
        // setting the background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BGgame7.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at:0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Beep(_ sender: Any) {
    }
    

    @IBAction func TouchScreen(_ sender: Any) {
        playSoundEffect(filename:"Beep19.wav")
         self.performSegue(withIdentifier: "showSignIn", sender: sender)
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
