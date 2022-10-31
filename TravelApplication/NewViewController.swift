//
//  NewViewController.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 03/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import MobileCoreServices
import MapKit

class NewViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UIPickerViewDelegate, CLLocationManagerDelegate {

    var saveDelegate: PlacesManagerDelegate?
    var locationManager: CLLocationManager!

    var experience = "" {
      didSet {
        detailLabel.text = experience
      }
    }
    var selectedExperience: String?
    var experienceee = [
       "Culture",
       "Adrenalin",
       "Cheap",
       "Nature",
       "Beach and sea",
       "Festival"
     ]
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var air_routeTextField: UITextField!
    @IBOutlet weak var specificationTextField: UITextField!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelExperience: UILabel!
    @IBOutlet weak var experiencePickerField: UITextField!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        dissmissPickerView()
        // Do any additional setup after loading the view.
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }

    }
    
    
      // MARK: - Navigation
      override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        
        if segue.identifier == "PickGame",
           let experiencePicker = segue.destination as? ExperiencePicker {
          experiencePicker.experienceData.selectedExperience = experience
        }
      }
    
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if let save = saveDelegate{
            let city = cityTextField.text ?? "No city"
            let country = countryTextField.text ?? "No country"
            let air_route = air_routeTextField.text ?? "No air route"
            let specification = specificationTextField.text ?? "No specification"
            let experienceee = experiencePickerField.text ?? "No experience"
            let latitude = 0.0
            let logitude = 0.0
            if let image = imageView.image?.pngData(){
                save.insertPlaces(city: city, country: country, experience: experienceee, air_route: air_route, specification: specification, latitude: Double(latitude), logitude: Double(logitude),image:image)
        }
      
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func createPickerView(){
          let pickerView = UIPickerView()
          pickerView.delegate = self
          experiencePickerField.inputView = pickerView
      }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
               return experienceee.count
       }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return experienceee[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        selectedExperience = experienceee[row]
        experiencePickerField.text = selectedExperience
       }

    func dissmissPickerView(){
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let OKButtton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(self.dissmissKeyboard))
            toolbar.setItems([OKButtton], animated: false)
            toolbar.isUserInteractionEnabled = true
            experiencePickerField.inputAccessoryView = toolbar

    }

    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    
    
//pridani fotky
    
    @IBAction func AddPhoto(_ sender: Any)
    {
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
        
        self.dismiss(animated:true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated:true, completion: nil)
    }
    
    
    //pridani lokace
    
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {

        let location = locations.last! as CLLocation

        /* you can use these values*/
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
       
       
       if let label = latitudeLabel {
           label.text = String(lat)
       }
       
       if let label = longitudeLabel {
              label.text = String(long)
          }
       
       let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
       let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
       let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
       
       CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
           if error != nil {
               print("Error")
           } else {
               if let place = placemark?[0]{
               }
           }
           
       }
    }
    
}


