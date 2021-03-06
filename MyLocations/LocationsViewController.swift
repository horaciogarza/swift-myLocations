import UIKit
import CoreData
import CoreLocation

class LocationsViewController: UITableViewController {
  var managedObjectContext: NSManagedObjectContext!
  lazy var fetchedResultsController: NSFetchedResultsController<Location> = {
    let fetchRequest = NSFetchRequest<Location>()

    let entity = Location.entity()
    fetchRequest.entity = entity
    
    let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    fetchRequest.fetchBatchSize = 20
    
    let fetchedResultsController = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: self.managedObjectContext,
      sectionNameKeyPath: nil,
      cacheName: "Locations")
    
    fetchedResultsController.delegate = self
    return fetchedResultsController
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    performFetch()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "EditLocation" {
      let navigationController = segue.destination as! UINavigationController
      
      let controller = navigationController.topViewController
                                          as! LocationDetailsViewController
      controller.managedObjectContext = managedObjectContext
      
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
        let location = fetchedResultsController.object(at: indexPath)
        controller.locationToEdit = location
      }
    }
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    let sectionInfo = fetchedResultsController.sections![section]
    return sectionInfo.numberOfObjects
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell",
                                             for: indexPath) as! LocationCell
    let location = fetchedResultsController.object(at: indexPath)
    cell.configure(for: location)
    
    return cell
  }
  
  func performFetch() {
    do {
      try fetchedResultsController.performFetch()
    } catch {
      fatalCoreDataError(error)
    }
  }
  
  
  deinit {
    fetchedResultsController.delegate = nil
  }
}

extension LocationsViewController: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(_
                controller: NSFetchedResultsController<NSFetchRequestResult>) {
    print("*** controllerWillChangeContent")
    tableView.beginUpdates()
  }
  
  func controller(
    _ controller: NSFetchedResultsController<NSFetchRequestResult>,
    didChange anObject: Any, at indexPath: IndexPath?,
    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    switch type {
    case.insert:
      print("*** NSFetchedResultsChangeINsert (object)")
      tableView.insertRows(at: [newIndexPath!], with: .fade)

    case .delete:
      print("*** NSFtechedResultsChangeDelete (object)")
      tableView.deleteRows(at: [indexPath!], with: .fade)
      
    case .update:
      print("*** NSFetchedResultsChangeUpdate (object")
      if let cell = tableView.cellForRow(at: indexPath!) as? LocationCell {
        let location = controller.object(at: indexPath!) as! Location
        cell.configure(for: location)
      }
    
    case .move:
      print("*** NSFetchedResultsChangeMove (object")
      tableView.deleteRows(at: [indexPath!], with: .fade)
      tableView.insertRows(at: [indexPath!], with: .fade)
    }
  }
  
  func controller(
    _ controller: NSFetchedResultsController<NSFetchRequestResult>,
    didChange sectionInfo: NSFetchedResultsSectionInfo,
    atSectionIndex sectionIndex: Int,
    for type: NSFetchedResultsChangeType) {

    switch type {
    case .insert:
      print("*** NSFetchedResultsChangeInsert (section)")
      tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
      
    case .delete:
      print("*** NSFetchedResultsChangeDelete (section)")
      tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
      
    case .update:
      print("*** NSFetchedResultsChangeUpdate (section)")
    case .move:
      print("*** NSFetchedResultsChangeMove (section)")
    }
  }
  
  func controllerDidChangeContent(
              _ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      print("*** controllerDidChangeContent")
      tableView.endUpdates()
  }
}








