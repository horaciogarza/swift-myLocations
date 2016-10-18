import CoreLocation
import UIKit

private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .medium
  formatter.timeStyle = .short
  return formatter
}()

class LocationDetailsViewController: UITableViewController {
  var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
  var placemark: CLPlacemark?
  
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var latitudeLabel: UILabel!
  @IBOutlet weak var longitudeLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    descriptionTextView.text = ""
    categoryLabel.text = ""
    latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
    longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
    
    if let placemark = placemark {
      addressLabel.text = string(from: placemark)
    } else {
      addressLabel.text = "No Address Found"
    }
    
    dateLabel.text = format(date: Date())
  }
  
  @IBAction func done() {
    dismiss(animated: true, completion: nil)   
  }
  
  @IBAction func cancel() {
    dismiss(animated: true, completion: nil)
  }
  
  func string (from placemark: CLPlacemark) -> String {
    var text = ""
    
    if let s = placemark.subThoroughfare {
      text += s + " "
    }
    if let s = placemark.thoroughfare {
      text += s + ", "
    }
    if let s = placemark.locality {
      text += s + ", "
    }
    if let s = placemark.administrativeArea {
      text += s + ", "
    }
    if let s = placemark.postalCode {
      text += s + ", "
    }
    if let s = placemark.country {
      text += s
    }
    return text
  }
  
  func format(date: Date) -> String {
    return dateFormatter.string(from: date)
  }
}
