//
//  GameOverViewController.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/15/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class GameOverViewController: UIViewController {
    var score:Int?
    let userID = FIRAuth.auth()?.currentUser?.uid
    @IBOutlet var scoreText: UILabel!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "landingBG.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at:0)
        scoreText.text = String(score!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
