//
//  GameEndViewController.swift
//  Tiny Dev
//
//  Created by Cassandra Torske on 2/16/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseStorageUI
import FirebaseStorage

class GameEndViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    let storage = FIRStorage.storage()
    var score:Int?

    @IBOutlet var highScoreTable: GameOverTableView!
   
    @IBAction func restartGame(_ sender: Any) {
         self.performSegue(withIdentifier: "showGame", sender: self)
    
    }
    override func viewDidLoad() {
        highScoreTable.delegate = self
        highScoreTable.dataSource = self
        super.viewDidLoad()
        print(score!)
        FirebaseManager.fillScores {
            () in
            DispatchQueue.main.async {
                self.highScoreTable.reloadData()
                print(FirebaseManager.profiles)
            }}

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseManager.profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameOverTableViewCell
        var sortedProfiles = FirebaseManager.profiles.sorted(by: {$0.score > $1.score})
        let u = sortedProfiles[indexPath.row]

        
     
        
        
        
        cell.profImage.image = UIImage(named: "dev1.png")
        cell.name.text = u.name
        cell.DevTitle.text = u.DevTitle
        cell.score.text = "\(u.score)"
        return cell
        
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
