import UIKit

enum Theme: Equatable {

    case light
    case dark

    static var current: Theme {
        return UITraitCollection.current.theme
    }

    init(_ traitCollection: UITraitCollection) {
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            self = .light

        case .dark:
            self = .dark

        @unknown default:
            self = .light
        }
    }
}

extension UITraitCollection {

    var theme: Theme { Theme(self) }
}
