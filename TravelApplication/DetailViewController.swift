//
//  DetailViewController.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 28/04/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class DetailViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var air_routeLabel: UILabel!
    @IBOutlet weak var specificationLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    var locationManager: CLLocationManager!

    @IBOutlet weak var mapView: MKMapView!
    
    
    var selectedPlaces: Places? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let places = selectedPlaces {
            if let city = cityLabel {
                city.text = places.city
            }
            if let country = countryLabel {
                country.text = places.country
            }
            if let air_route = air_routeLabel {
                air_route.text = places.air_route
                       }
            if let specification = specificationLabel {
            specification.text = places.specification
                   }
            if let image = imageView{
                image.image = UIImage(data: selectedPlaces!.image!)
          }
        }
    }

       override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
           configureView()
           /*centerMapOnLocation(location:
               CLLocationCoordinate2DMake(CLLocationDegrees(selectedPlaces!.latitude), CLLocationDegrees(selectedPlaces!.longitude)))
           addPin()*/
       }
       
    /*func centerMapOnLocation(location: CLLocationCoordinate2D) {
              let side: CLLocationDistance = 250 // meters
              let coordinateRegion = MKCoordinateRegion(
                  center: location,
                  latitudinalMeters: side,
                  longitudinalMeters: side)
              mapView.setRegion(coordinateRegion, animated: true)
          }
    
       func initLocationManager() {
           locationManager = CLLocationManager()
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation()
       }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        centerMapOnLocation(location: locations[0].coordinate)
    }


    func addPin(){
        let annotation = MKPointAnnotation()
        annotation.title = selectedPlaces?.city
        annotation.coordinate = CLLocationCoordinate2D(latitude: selectedPlaces!.latitude, longitude: selectedPlaces!.longitude)
        mapView.addAnnotation(annotation)
    }*/


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditPlaces" {
            let controller = (segue.destination as! UINavigationController).topViewController as! EditViewController
            if let places = selectedPlaces{
                controller.editedPlaces = places
            }
        }
        
    }
    
}
