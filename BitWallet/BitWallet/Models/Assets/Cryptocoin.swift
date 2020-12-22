import Foundation

struct Cryptocoin: AssetUnit {

    let type: AssetType = .cryptocoin

    let id: String
    let symbol: String
    let name: String
    let averagePrice: Double
    let logo: ImageModel?
    let fiatPricePrecision: Int?
}

extension Cryptocoin {

    init(withDTO dto: CryptocoinDTO) {
        self.id = dto.attributes.id
        self.symbol = dto.attributes.symbol
        self.name = dto.attributes.name
        self.averagePrice = dto.attributes.averagePrice

        if
            let lightLogoURL = dto.attributes.lightLogo.flatMap(URL.init),
            let darkLogoURL = dto.attributes.darkLogo.flatMap(URL.init)
        {
            self.logo = ImageModel(lightImageURL: lightLogoURL, darkImageURL: darkLogoURL)
        } else {
            self.logo = nil
        }

        self.fiatPricePrecision = dto.attributes.fiatPricePrecision
    }
}
