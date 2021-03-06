//
//  FirebaseManager.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/16/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class FirebaseManager: NSObject {
    
    static let databaseRef = FIRDatabase.database().reference()
    static var currentUserId:String = ""
    static var currentUser:FIRUser? = nil
    static var uid:String = ""
    static var oldScore:Int?
    static var profiles = [Profile]()
    
    static func Login(email : String, password : String, completion: @escaping (_ success:Bool)->Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                currentUser = user
                currentUserId = (user?.uid)!
                completion(true)
            }
        })
    }


    static func CreateAccount(email:String, password:String, name:String, DevTitle:String, completion: @escaping (_ result:String) -> Void) {
        FIRAuth.auth()?.createUser(withEmail:email, password:password, completion: {(user,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
    
                            
                            AddUser(email:email, name:name, DevTitle:DevTitle)
                            Login(email:email, password:password) {
                                (success:Bool) in
                                if(success) {
                                    print("Login successful after account creation")
                                } else {
                                    print("Login unsuccessful after account creation")
                                }
                            }
                            completion("")


          
        })
    }
    
    static func AddUser(email:String, name:String, DevTitle:String) {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let post = ["uid": uid!, "email": email, "name": name, "DevTitle":DevTitle]
        databaseRef.child("users").child(uid!).setValue(post)
    }
    
    static func uploadScore(score:Int) {
        let uid = FIRAuth.auth()?.currentUser?.uid
            databaseRef.child("users").child(uid!).updateChildValues(["score": score])
        
                }
    
    static func fillScores(completion: @escaping () -> Void) {
        profiles = []
    
        databaseRef.child("users").observe(.childAdded, with: {
            snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String:AnyObject] {
                let name = result["name"]! as! String
                let DevTitle = result["DevTitle"]! as! String
                let score = result["score"]! as! Int
                
                let u = Profile(name:name, DevTitle:DevTitle, score:score)
                
                FirebaseManager.profiles.append(u)
            }
            completion()
        })
    }
            
    
}
    


