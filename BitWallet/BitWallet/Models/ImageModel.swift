import Foundation

struct ImageModel {

    let lightImageURL: URL
    let darkImageURL: URL

    var url: URL {
        switch Theme.current {
        case .light:
            return lightImageURL

        case .dark:
            return darkImageURL
        }
    }
}
