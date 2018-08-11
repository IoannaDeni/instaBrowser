//
//  PhotoViewController.swift
//  instaBrowser
//
//  Created by user143365 on 8/10/18.
//  Copyright © 2018 Ioanna Deni. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class PhotoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var captionLabel: UITextField!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var albumButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAlbumClicked(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        present(vc, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        postImageView.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        captionLabel.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onShare(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Post.postUserImage(image: postImageView.image,
                           withCaption: captionLabel.text,
                           withCompletion: { (success: Bool, error: Error?) -> Void in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                MBProgressHUD.hide(for: self.view, animated: true)
                                self.captionLabel.resignFirstResponder()
                                self.dismiss(animated: true, completion: nil)
                            }
                            }
        )
                            
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
