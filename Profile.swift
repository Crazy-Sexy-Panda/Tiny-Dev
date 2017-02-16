//
//  Profile.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/16/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit

class Profile: NSObject {
    
    var name:String
    var DevTitle:String
    var score:Int
    var profImageUrl:String
    
    init(name:String, DevTitle:String, score:Int, profImageUrl:String) {
        self.name = name
        self.DevTitle = DevTitle
        self.score = score
        self.profImageUrl = profImageUrl
        
    }


    
    
}
