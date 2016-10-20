import Foundation
import Dispatch

let MyManagedObjectContextSaveDidFailNotification = Notification.Name(
                    rawValue: "MyManagedObjectContextSaveDidFailNotification")

let applicationDocumentsDirectory: URL = {
  let paths = FileManager.default.urls(for: .documentDirectory,
                                       in: .userDomainMask)
  return paths[0]
}()

func fatalCoreDataError(_ error: Error) {
  print("*** Fatal error: \(error)")
  NotificationCenter.default.post(
                            name: MyManagedObjectContextSaveDidFailNotification,
                            object: nil)
}

func afterDelay(_ seconds: Double, closure: @escaping () -> ()) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds,
                                execute: closure)
}


