//
//  CustomPinAnnotation.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 23/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import MapKit
class CustomePinAnnotation: MKPointAnnotation {
let discipline: String? = nil
    
//pin image
//var pinImage:String!
var annotation: MKPointAnnotation!
var pinImage2: String!

    
var pinColor: UIColor  {
      switch discipline {
      case "Monument":
        return .red
      case "Mountain":
        return .cyan
      case "Beach":
        return .yellow
      case "Culture":
        return .purple
      case "Sport":
        return .green
      case "Ski":
        return .blue
      case "Extreme sport":
        return .orange
      default:
        return .black
      }
    }
    
var pinImage: UIImage {
      guard let name = discipline else { return #imageLiteral(resourceName: "pin") }
      
      switch name {
      case "Monument":
        return #imageLiteral(resourceName: "monument")
      case "Mountain":
        return #imageLiteral(resourceName: "mountain")
      case "Beach":
        return #imageLiteral(resourceName: "beach")
      case "Culture":
        return #imageLiteral(resourceName: "mask")
      case "Sport":
        return #imageLiteral(resourceName: "sport")
      case "Ski":
        return #imageLiteral(resourceName: "ski")
      case "Extreme sport":
        return #imageLiteral(resourceName: "extreme")
      default:
        return #imageLiteral(resourceName: "pin")
      }
    }
}
