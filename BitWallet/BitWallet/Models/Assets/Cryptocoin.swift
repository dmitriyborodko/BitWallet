import Foundation

struct Cryptocoin: AssetUnit {

    let type: AssetType = .cryptocoin

    let symbol: String
    let name: String
    let averagePrice: String?
    let logo: ImageModel?
}

extension Cryptocoin {

    init(withDTO dto: CryptocoinDTO) {
        self.symbol = dto.attributes.symbol
        self.name = dto.attributes.name

        self.averagePrice = PriceFormatter.format(
            price: dto.attributes.averagePrice,
            precision: dto.attributes.fiatPricePrecision
        )

        if
            let lightLogoURL = dto.attributes.lightLogo.flatMap(URL.init),
            let darkLogoURL = dto.attributes.darkLogo.flatMap(URL.init)
        {
            self.logo = ImageModel(lightImageURL: lightLogoURL, darkImageURL: darkLogoURL)
        } else {
            self.logo = nil
        }
    }
}
