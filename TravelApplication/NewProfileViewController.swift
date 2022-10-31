//
//  NewProfileViewController.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 21/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import MobileCoreServices

class NewProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var saveDelegate: ProfileManagerDelegate?
    
    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var locationTextFiled: UITextField!
    @IBOutlet weak var profilePhoto: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func cancelNewProfile(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveNewProfile(_ sender: Any) {
        let userName = userNameTextFiled.text ?? "No userName"
        let location = locationTextFiled.text ?? "No location"
        let email = "No email"

        
        
        if let image = profilePhoto.image?.pngData(){
            if let save = saveDelegate{
                save.saveProfile(name: userName, location: location, image: image, email: email)
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseProfilePhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeImage as String]
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let possibleImage =
            info[.editedImage] as? UIImage {
            // present in imageView
            profilePhoto.image = possibleImage
        } else if let possibleImage =
            info[.originalImage] as? UIImage {
            // present in imageView
            profilePhoto.image = possibleImage
        }
        profilePhoto.contentMode = .scaleAspectFill
        
        self.dismiss(animated:true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated:true, completion: nil)
    }
    
}

