//
//  PinsMapViewController.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 16/06/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class PinsMapViewController: UIViewController, CLLocationManagerDelegate , NSFetchedResultsControllerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchPlaces()       
    }
    
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let side: CLLocationDistance = 250 // meters
        let coordinateRegion = MKCoordinateRegion(
            center: location,
            latitudinalMeters: side,
            longitudinalMeters: side)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        centerMapOnLocation(location: locations[0].coordinate)
    }
    
    func fetchPlaces(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Places>(entityName: "Places")
        
        do{
            let pins = try managedContext.fetch(fetchRequest)
            for pin in pins{
                let annotation = MKPointAnnotation()
                annotation.title = pin.city ?? "No city"
                let lat = pin.latitude 
                let long = pin.longitude 
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                mapView.addAnnotation(annotation)
            }
            
        }
        catch let _ as NSError{
            print("Failed")
        }
    }
    
    @objc func addAnnotation(location : Places)-> MKAnnotation
      {
          //  let coordinates = mapView.convert(location, toCoordinateFrom: mapView)
          
          let annotation = MKPointAnnotation()
          
          annotation.title = location.city
          //You can also add a subtitle that displays under the annotation such as
          annotation.subtitle = location.country ?? "Country" + "\(annotation.coordinate.latitude) \(annotation.coordinate.longitude)"
          
          mapView.addAnnotation(annotation)
          
          return annotation
      }
      
      @objc func newLocationAdded(_ notification: Notification) {
          guard let location = notification.userInfo?["location"] as? Places else {
              return
          }
          
          let annotation = addAnnotation(location: location)
          mapView.addAnnotation(annotation)
      }
    
    
}
