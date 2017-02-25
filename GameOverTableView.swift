//
//  GameOverTableView.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/25/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit

class GameOverTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   
    
        
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FirebaseManager.profiles.count
    }
    
   
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("RUNNING RUNNING RUNNING")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameOverTableViewCell
        var sortedProfiles = FirebaseManager.profiles.sorted(by: {$0.score > $1.score})
        let u = sortedProfiles[indexPath.row]
        cell.name.text = u.name
        cell.DevTitle.text = u.DevTitle
        cell.score.text = "\(u.score)"
        var finalImage = u.getProfileImage()
        print(u.getProfileImage())
        return cell
        
    }

    
    
}
