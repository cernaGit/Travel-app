//
//  ExperiencePicker.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 17/05/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit

class ExperiencePicker: UITableViewController {
  // MARK: - Properties
  let experienceData = ExperienceData()
}

// MARK: - UITableViewDataSource
extension ExperiencePicker {
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    experienceData.numberOfExperience()
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ExperienceCell",
      for: indexPath)
    cell.textLabel?.text = experienceData.experienceName(at: indexPath)
    
    if indexPath.row == experienceData.selectedExperienceIndex {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ExperiencePicker {
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    tableView.deselectRow(at: indexPath, animated: true)

    if let index = experienceData.selectedExperienceIndex {
      let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
      cell?.accessoryType = .none
    }
    
    experienceData.selectExperience(at: indexPath)
    
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .checkmark

    performSegue(withIdentifier: "unwind", sender: cell)
  }
}
