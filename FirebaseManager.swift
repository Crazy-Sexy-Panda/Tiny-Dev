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
    static var profileImageUrl:String = ""
    static var uid:String = ""
    
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


    static func CreateAccount(email:String, password:String, name:String, DevTitle:String, profileImage: UIImage, completion: @escaping (_ result:String) -> Void) {
        FIRAuth.auth()?.createUser(withEmail:email, password:password, completion: {(user,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let profileImageRef = FIRStorage.storage().reference().child("profileImages").child("\(NSUUID().uuidString).jpg")
            if let imageData = UIImageJPEGRepresentation(profileImage, 0.25) {
                profileImageRef.put(imageData, metadata:nil) {
                    metadata, error in
                    if (error != nil) {
                        print(error)
                        return
                    } else {
                        print(metadata)
                        if let downloadUrl = metadata?.downloadURL()?.absoluteString{
                                self.profileImageUrl = downloadUrl
                            
                            AddUser(email:email, name:name, DevTitle:DevTitle, profImageUrl: profileImageUrl)
                            Login(email:email, password:password) {
                                (success:Bool) in
                                if(success) {
                                    print("Login successful after account creation")
                                } else {
                                    print("Login unsuccessful after account creation")
                                }
                            }
                            completion("") 
                                
    
                            
                        }
                    }
                }
            }
        
          
        })
    }
    
    static func AddUser(email:String, name:String, DevTitle:String, profImageUrl:String) {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let post = ["uid": uid!, "email": email, "name": name, "DevTitle":DevTitle, "profImageUrl": profImageUrl ]
        databaseRef.child("users").child(uid!).setValue(post)
    }
    
//    static func uploadScore(score:Int) {
//        let oldScore:Int?
//        print(score)
//        let uid = FIRAuth.auth()?.currentUser?.uid
//        databaseRef.child("users").child(uid!).child("score").observeSingleEvent(of: .childAdded, with: { snapshot in
//            oldScore = snapshot.value as! Int
//
//            })
////        if(oldScore < score) {
////        databaseRef.child("users").child(uid!).updateChildValues(["score": score])
////        }
//        
//
//    }
}
    


