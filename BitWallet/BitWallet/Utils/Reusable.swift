import UIKit

protocol Reusable: AnyObject {

    static var reuseIdentifier: String { get }
}

extension Reusable {

    static var reuseIdentifier: String { String(describing: self) }
}

extension UITableView {

    func registerAndDequeueReusableCell<T>(
        reuseIdentifier: String = T.reuseIdentifier
    ) -> T where T: UITableViewCell & Reusable {
        if let cell = dequeueReusableCell(withIdentifier: reuseIdentifier) as? T {
            return cell
        } else {
            register(T.self, forCellReuseIdentifier: reuseIdentifier)

            return dequeueReusableCell(withIdentifier: reuseIdentifier) as! T
        }
    }
}
