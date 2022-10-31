//
//  Profile.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 09/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import Foundation

class Profile{
    var name: String = "No name"
    var location: String = "No address"
    var visitedPlaces: Int = 0
    
    init(name: String, location: String, visitedPlaces: Int) {
        self.name = name
        self.location = location
        self.visitedPlaces = visitedPlaces
    }
}
