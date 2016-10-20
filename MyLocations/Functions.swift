import Foundation
import Dispatch

func afterDelay(_ seconds: Double, closure: @escaping () -> ()) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds,
                                execute: closure)
}

let applicationDocumentsDirectory: URL = {
  let paths = FileManager.default.urls(for: .documentDirectory,
                                       in: .userDomainMask)
  return paths[0]
}()

