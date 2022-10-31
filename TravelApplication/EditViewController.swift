//
//  EditViewController.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 03/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate {

    var saveDelegate: PlacesManagerDelegate?
    var editedPlaces: Places?{
        didSet {
            // Update the view.
            configureView()
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
    @IBOutlet weak var experienceTextField: UITextField!
    @IBOutlet weak var addPhoto: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    
    @IBAction func cancel2Clicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if let save = saveDelegate{
            let city = cityTextField.text ?? "No city"
            let country = countryTextField.text ?? "No country"
            let air_route = air_routeTextField.text ?? "No air route"
            let specification = specificationTextField.text ?? "No specification"
            let experience = "No experience"
            let latitude = 0.0
            let logitude = 0.0
            if let image = imageView.image?.pngData(){
            save.insertPlaces(city: city, country: country, experience: experience, air_route: air_route, specification: specification, latitude: Double(latitude), logitude: Double(logitude), image: image)
        }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func createPickerView(){
          let pickerView = UIPickerView()
          pickerView.delegate = self
          experienceTextField.inputView = pickerView
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
        experienceTextField.text = selectedExperience
       }

    func dissmissPickerView(){
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let OKButtton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(self.dissmissKeyboard))
            toolbar.setItems([OKButtton], animated: false)
            toolbar.isUserInteractionEnabled = true
            experienceTextField.inputAccessoryView = toolbar

    }

    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let places = editedPlaces {
            if let city = cityTextField {
                city.text = places.city
            }
            if let country = countryTextField {
                country.text = places.country
            }
        }
    }
}
    

