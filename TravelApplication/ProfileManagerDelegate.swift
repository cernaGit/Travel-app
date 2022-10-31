//
//  ProfileManagerDelegate.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 14/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import CoreData

protocol ProfileManagerDelegate {
    func saveProfile(name: String, location: String, image: Data, email: String)
}
