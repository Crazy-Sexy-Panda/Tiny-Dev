////
////  DragImage.swift
////  Tiny Dev
////
////  Created by Daisha Walton on 2/13/17.
////  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
////
//
//import UIKit
//import SpriteKit
//
//class DragImage: SKSpriteNode {
//    
//    
//    var originalPosition: CGPoint!
//    var dropTarget: UIView?
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        originalPosition = self.position
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            
//            let position = touch.location(in: self.superview)
//            self.center = CGPoint(x: position.x, y: position.y)
//            
//        }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first, let target = dropTarget {
//            let position = touch.location(in: self.superview)
//            
//            // if we dropped the image onto the target fire off a onTargetDropped notification
//            if target.frame.contains(position) {
//                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "onTargetDropped"), object: nil))
//            
//        }
//        self.position = originalPosition
//   
//    }
//
//}
