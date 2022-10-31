//
//  EditProfileViewController.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 09/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import MobileCoreServices

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var saveDelegate: ProfileManagerDelegate?
    var editedProfile: Profile?{
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
          //!!!!!!!! configureView()
       }
       

    
    @IBAction func cancelEditProfile(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
       
    @IBAction func saveEditProfile(_ sender: Any) {
           if let save = saveDelegate{
               let userName = userNameTextField.text ?? "No name"
               let location = locationTextField.text ?? "No location"
                let email =  "No email"

            if let image = imageView.image?.pngData(){

                save.saveProfile(name: userName, location: location, image: image, email: email)
           }
        }
           dismiss(animated: true, completion: nil)
       }
       
       func configureView() {
           // Update the user interface for the detail item.
           if let profile = editedProfile {
               if let userName = userNameTextField {
                userName.text = profile.name
               }
               if let location = locationTextField {
                   location.text = profile.location
               }
           }
       }

    @IBAction func chooseProfilePhoto(_ sender: Any) {
    let picker = UIImagePickerController()
                    picker.delegate = self
                    picker.sourceType = .photoLibrary
                    picker.mediaTypes = [kUTTypeImage as String]
                    self.present(picker, animated: true, completion: nil)
                }
    
               //osetreni otevreni galerie - nedodelano
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    imagePicker.allowsEditing = true
                    self.present(imagePicker, animated: true, completion: nil)
                      }
                   
                
                if let possibleImage =
                    info[.editedImage] as? UIImage {
                    // present in imageView
                    imageView.image = possibleImage
                } else if let possibleImage =
                    info[.originalImage] as? UIImage {
                    // present in imageView
                    imageView.image = possibleImage
                }
                imageView.contentMode = .scaleAspectFill
                
                self.dismiss(animated:true, completion: nil)
            }
            
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
                self.dismiss(animated:true, completion: nil)
            }
            
        }

