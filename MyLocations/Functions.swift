import Foundation
import Dispatch

func afterDelay(_ seconds: Double, closure: @escaping () -> ()) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds,
                                execute: closure)
}
