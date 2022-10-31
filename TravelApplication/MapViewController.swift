//
//  MapViewController.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 09/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationManager: CLLocationManager!
    @IBOutlet weak var textFieldFotAddress: UITextField!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var pinView: MKAnnotationView!
    var places: [Places]! = []
    var appDelegate: AppDelegate!
    var sharedContext: NSManagedObjectContext!
    
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
        mapView.userTrackingMode = .follow
        mapView.delegate = self

//        self.mapView.addAnnotations(getData()!)

        //self.mapView.addAnnotations(fetchAllPins() as! [MKAnnotation])
        
        //Annotation
        
        /*let longPressGestureRecogn = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(press:)))
         longPressGestureRecogn.minimumPressDuration = 2.0
         mapView.addGestureRecognizer(longPressGestureRecogn)*/
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpladeLocation location: [CLLocation]) {
        if let location = location.first{
            locationManager.stopUpdatingLocation()
            render (location: location)
        }
    }
    
    func render(location: CLLocation)  {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 50.4523, longitudeDelta: 15.5467)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        //testovani pozice
        print(coordinate.latitude)
        print(coordinate.longitude)
        
        //pridani pinu na mapu
        addAnnotation(location: Places.init())
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    /* func centerMapOnLocation(location: CLLocationCoordinate2D) {
     let side: CLLocationDistance = 250 // meters
     let coordinateRegion = MKCoordinateRegion(
     center: location,
     latitudinalMeters: side,
     longitudinalMeters: side)
     mapView.setRegion(coordinateRegion, animated: true)
     }*/
    
    
    /* func locationManager(_ manager: CLLocationManager,
     didUpdateLocations locations: [CLLocation]) {
     print("locations = \(locations)")
     centerMapOnLocation(location: locations[0].coordinate)
     }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors " + error.localizedDescription)
    }
    
    /* @objc func addAnnotation(press:UILongPressGestureRecognizer)
     {
     if press.state == .began
     {
     let location = press.location(in: mapView)
     let coordinates = mapView.convert(location, toCoordinateFrom: mapView)
     
     let annotation = CustomePinAnnotation()
     annotation.coordinate = coordinates
     
     annotation.title = "ChoosenCity"
     //You can also add a subtitle that displays under the annotation such as
     annotation.subtitle = "Country " + "\(annotation.coordinate.latitude) \(annotation.coordinate.longitude)"
     annotation.pinImage2 = "pin"
     
     mapView.addAnnotation(annotation)
     }
     }*/
    
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
    
    
    //Trackovani
    
    @IBAction func getDirectionTapped(_ sender: Any) {
        getAddress()
    }
    func getAddress() {
           let geoCoder = CLGeocoder()
           geoCoder.geocodeAddressString(textFieldFotAddress.text!) { (placemarks, error) in
               guard let placemarks = placemarks, let location = placemarks.first?.location
                   else {
                       print("No Location Found")
                       return
               }
               print(location)
               self.mapThis(destinationCord: location.coordinate)
               
           }
       }
    func mapThis(destinationCord : CLLocationCoordinate2D) {
           
           let souceCordinate = (locationManager.location?.coordinate)!
           
           let soucePlaceMark = MKPlacemark(coordinate: souceCordinate)
           let destPlaceMark = MKPlacemark(coordinate: destinationCord)
           
           let sourceItem = MKMapItem(placemark: soucePlaceMark)
           let destItem = MKMapItem(placemark: destPlaceMark)
           
           let destinationRequest = MKDirections.Request()
           destinationRequest.source = sourceItem
           destinationRequest.destination = destItem
           destinationRequest.transportType = .automobile
           destinationRequest.requestsAlternateRoutes = true
           
           let directions = MKDirections(request: destinationRequest)
           directions.calculate { (response, error) in
               guard let response = response else {
                   if let error = error {
                       print("Something is wrong :(")
                   }
                   return
               }
               
             let route = response.routes[0]
             self.mapView.addOverlay(route.polyline)
             self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
               
           }
       }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .red
        return render
    }
}

