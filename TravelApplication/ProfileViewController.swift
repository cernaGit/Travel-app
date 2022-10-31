//
//  ProfileViewController.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 09/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices


class ProfileViewController: UIViewController, NSFetchedResultsControllerDelegate,
ProfileManagerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func saveProfile(name: String, location: String, image: Data, email:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entita = NSEntityDescription.entity(forEntityName: "Profile", in: managedContext)!
        let newProfile = NSManagedObject(entity: entita, insertInto: managedContext)
        newProfile.setValue(name, forKey: "userName")
        newProfile.setValue(location, forKey: "location")
        newProfile.setValue(image, forKey: "image")
        
        if let userName = userNameLabel {
            userName.text = name
        }
        if let location2 = locationLabel {
            location2.text = location
        }
        do{
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
    
    var selectedProfile: Profile? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    var managedObjectContext: NSManagedObjectContext? = nil
    let imagePicker = UIImagePickerController()
    var saveDelegate: ProfileManagerDelegate?
    
    
    
    var profil: [NSManagedObject] = []
    var places: [Places] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        loadArray()
        loadProfile()
    }
    
    func configureView() {
        if let profile = selectedProfile {
            if let userName = userNameLabel {
                userName.text = profile.name
            }
            if let location = locationLabel {
                location.text = profile.location
            }
            if let email = emailLabel {
                email.text = profile.email
            }
            if let image = imageView{
                image.image = UIImage(data: selectedProfile!.imageProfile!)
            }
        }
    }
    
    
    func loadProfile() {
        let lastProfile = profil.last
        if let userName = userNameLabel {
            userName.text = lastProfile?.value(forKeyPath: "userName")as? String
        }
        if let location = locationLabel {
            location.text = lastProfile?.value(forKeyPath: "location")as? String
        }
        if let email = emailLabel {
            email.text = lastProfile?.value(forKeyPath: "email")as? String
        }
        if let image = imageView{
            image.image = lastProfile?.value(forKeyPath: "image") as? UIImage
        }
    }
    func loadArray() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Profile")
        do{
            profil = try managedContext.fetch(fetchRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    /*func loadPlaces()  {
     let label = places.count
     viditedPlacesLabel.text = String(label)
     }*/
    
    func numberProfile() -> Int{
        return profil.count
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
            imageView.image = possibleImage
        } else if let possibleImage =
            info[.originalImage] as? UIImage {
            // present in imageView
            imageView.image = possibleImage
        }
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.size.width/3
        
        self.dismiss(animated:true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated:true, completion: nil)
    }
    
    @IBAction func addUserName(_ sender: Any) {
        let alert = UIAlertController(title: "Add username",
                                      message: "Username", preferredStyle: .alert)
        
        
        let alertUlozit = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first, let userNameAdd = textField.text else {return}
            self.save(userNameAdd)
        }
        let alertUkncit = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(alertUkncit)
        alert.addAction(alertUlozit)
        present(alert, animated: true, completion: nil)
        
    }
    
    func save(_ name: String) {
        if let userName = userNameLabel {
            userName.text = name
        }
    }
    
    @IBAction func locationAdd(_ sender: Any) {
        let alert = UIAlertController(title: "Add location (Hometown)",
                                      message: "Location", preferredStyle: .alert)
        
        
        let alertUlozit = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first, let locationAdd = textField.text else {return}
            self.save2(locationAdd)
        }
        let alertUkncit = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(alertUkncit)
        alert.addAction(alertUlozit)
        present(alert, animated: true, completion: nil)
        
    }
    
    func save2(_ hometown: String) {
        if let location = locationLabel {
            location.text = hometown
        }
    }
    
    @IBAction func addEmail(_ sender: Any) {
    let alert = UIAlertController(title: "Add e-mail",
                                          message: "e-mail", preferredStyle: .alert)
            
            
            let alertUlozit = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
                guard let textField = alert.textFields?.first, let locationAdd = textField.text else {return}
                self.save3(locationAdd)
            }
            let alertUkncit = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            alert.addTextField(configurationHandler: nil)
            alert.addAction(alertUkncit)
            alert.addAction(alertUlozit)
            present(alert, animated: true, completion: nil)
            
        }
        
        func save3(_ emaill: String) {
            if let email = emailLabel {
                email.text = emaill
            }
        }
    
    
    @IBAction func infoAboutApp(_ sender: Any) {
        let alert = UIAlertController(title: "Information about TravelApplication",
                                          message: "This application serves as a travel diary. Here you can add places with photos and your memories. Created by Kateřina Černá. Version 1.0", preferredStyle: .alert)
            
            let alertUkoncit = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            let alertOk = UIAlertAction(title: "OK", style: .default)
            alert.addAction(alertUkoncit)
            alert.addAction(alertOk)
            present(alert, animated: true, completion: nil)
            
        }
    
}



