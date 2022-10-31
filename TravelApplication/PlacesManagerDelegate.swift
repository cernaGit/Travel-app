//
//  PlacesManagerDelegate.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 03/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import CoreData

protocol PlacesManagerDelegate {
    func insertPlaces(city: String, country: String, experience: String, air_route: String, specification: String, latitude:Double, logitude:Double,image: Data)
}


