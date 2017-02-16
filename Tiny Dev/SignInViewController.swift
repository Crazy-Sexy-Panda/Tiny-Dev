//
//  SignInViewController.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/15/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var Name: UITextField!
    @IBOutlet var DevTitle: UITextField!
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButton_click(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showGame", sender:sender)
    }
    
    
    @IBAction func getPhoto(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(image, animated:true, completion:nil)
        
    }


    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickerInfo:NSDictionary = info as NSDictionary
        let img:UIImage = pickerInfo.object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
        imageView.image = img
        self.dismiss(animated:true, completion: nil)
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
