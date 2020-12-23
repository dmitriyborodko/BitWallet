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

extension ImageModel {

    init?(lightImagePath: String?, darkImagePath: String?) {
        if
            let lightLogoURL = lightImagePath.flatMap(URL.init),
            let darkLogoURL = darkImagePath.flatMap(URL.init)
        {
            self.init(lightImageURL: lightLogoURL, darkImageURL: darkLogoURL)
        } else {
            return nil
        }
    }
}
