import UIKit

extension UIResponder {
  static var typeName: String {
    return String(describing: self)
  }
}
