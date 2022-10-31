//
//  MasterViewController.swift
//  TravelApplication
//
//  Created by Kateřina Černá on 28/04/2020.
//  Copyright © 2020 Kateřina Černá. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, PlacesManagerDelegate {
   
    
    var managedObjectContext: NSManagedObjectContext? = nil
    var detailViewController: DetailViewController? = nil
    var placesList = [Places]()



    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /*func savePlaces(city: String, country: String, experience: String, air_route: String, specification: String) {
        let newPlaces = Places()
        placesList.insert(newPlaces, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }*/
    
    
     @objc
       func insertNewObject(_ sender: Any) {
           let context = self.fetchedResultsController.managedObjectContext
           let newEvent = Event(context: context)
                
           // If appropriate, configure the new managed object.
           newEvent.timestamp = Date()

           // Save the context.
           do {
               try context.save()
           } catch {
               // Replace this implementation with code to handle the error appropriately.
               // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
               let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
           }
       }
    
    func insertPlaces(city: String, country: String, experience: String, air_route: String, specification: String,latitude: Double, logitude: Double, image:Data) {
        let context = self.fetchedResultsController.managedObjectContext
        let newPlaces = Places(context: context)
             
        // If appropriate, configure the new managed object.
        newPlaces.city = city
        newPlaces.country = country
        newPlaces.experience = experience
        newPlaces.air_route = air_route
        newPlaces.specification = specification
        newPlaces.latitude = latitude
        newPlaces.longitude = logitude
        
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    //imsertPicture
    
       func insertPicture(image: Data) {
        let context = self.fetchedResultsController.managedObjectContext
        let newPicture = Places(context: context)
        
        newPicture.image = image
        
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = fetchedResultsController.object(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.selectedPlaces = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
        else if segue.identifier == "newPlaces" {
            let controller = (segue.destination as! UINavigationController).topViewController as! NewViewController
            controller.saveDelegate = self
        }
       /* if segue.identifier == "ExperienceGame",
                        let experiencePicker = segue.destination as? ExperiencePicker {
                       experiencePicker.experienceData.selectedExperience = experience
                     }
        */
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
            return fetchedResultsController.sections?.count ?? 0
        }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let sectionInfo = fetchedResultsController.sections![section]
            return sectionInfo.numberOfObjects
        }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let places = fetchedResultsController.object(at: indexPath)
            configureCell(cell, withPlaces: places)
            return cell
        }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let context = fetchedResultsController.managedObjectContext
                context.delete(fetchedResultsController.object(at: indexPath))
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

        func configureCell(_ cell: UITableViewCell, withPlaces places: Places) {
            cell.textLabel!.text = places.city
        }
    
    @objc func newLocationAdded(_ notification: Notification) {
      tableView.reloadData()
    }

        // MARK: - Fetched results controller

        var fetchedResultsController: NSFetchedResultsController<Places> {
            if _fetchedResultsController != nil {
                return _fetchedResultsController!
            }
            
            self.managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<Places> = Places.fetchRequest()
            
            // Set the batch size to a suitable number.
            fetchRequest.fetchBatchSize = 20
            
            // Edit the sort key as appropriate.
            let sortDescriptor = NSSortDescriptor(key: "city", ascending: false)
            
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            // Edit the section name key path and cache name if appropriate.
            // nil for section name key path means "no sections".
            let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "")
            aFetchedResultsController.delegate = self
            _fetchedResultsController = aFetchedResultsController
            
            do {
                try _fetchedResultsController!.performFetch()
            } catch {
                 // Replace this implementation with code to handle the error appropriately.
                 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 let nserror = error as NSError
                 fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
            return _fetchedResultsController!
        }
        var _fetchedResultsController: NSFetchedResultsController<Places>? = nil

        func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.beginUpdates()
        }

        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
            switch type {
                case .insert:
                    tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
                case .delete:
                    tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
                default:
                    return
            }
        }

        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            switch type {
                case .insert:
                    tableView.insertRows(at: [newIndexPath!], with: .fade)
                case .delete:
                    tableView.deleteRows(at: [indexPath!], with: .fade)
                case .update:
                    configureCell(tableView.cellForRow(at: indexPath!)!, withPlaces: anObject as! Places)
                case .move:
                    configureCell(tableView.cellForRow(at: indexPath!)!, withPlaces: anObject as! Places)
                    tableView.moveRow(at: indexPath!, to: newIndexPath!)
                default:
                    return
            }
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.endUpdates()
        }

        /*
         // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
         
         func controllerDidChangeContent(controller: NSFetchedResultsController) {
             // In the simplest, most efficient, case, reload the table view.
             tableView.reloadData()
         }
         */


}
