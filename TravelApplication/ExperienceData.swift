//
//  ExperienceData.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 17/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit

class ExperienceData: NSObject {
  // MARK: - Properties
  var experience = [
    "Culture",
    "Adrenalin",
    "Cheap",
    "Nature",
    "Beach and sea",
    "Festival"
  ]

  var selectedExperience: String? {
    didSet {
      if let selectedExperience = selectedExperience,
        let index = experience.firstIndex(of: selectedExperience) {
        selectedExperienceIndex = index
      }
    }
  }

  var selectedExperienceIndex: Int?

  // MARK: - Datasource Methods
  func selectExperience(at indexPath: IndexPath) {
    selectedExperience = experience[indexPath.row]
  }

  func numberOfExperience() -> Int {
    experience.count
  }

  func experienceName(at indexPath: IndexPath) -> String {
    experience[indexPath.row]
  }
}
