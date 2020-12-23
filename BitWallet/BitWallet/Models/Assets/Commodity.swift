import Foundation

struct Commodity: AssetUnit {

    let type: AssetType = .commodity

    let symbol: String
    let name: String
    let averagePrice: String?
    let logo: ImageModel?
}

extension Commodity {

    init(withDTO dto: CommodityDTO) {
        self.symbol = dto.attributes.symbol
        self.name = dto.attributes.name

        self.averagePrice = PriceFormatter.format(
            price: dto.attributes.averagePrice,
            precision: dto.attributes.fiatPricePrecision
        )

        self.logo = ImageModel(
            lightImagePath: dto.attributes.lightLogo,
            darkImagePath: dto.attributes.darkLogo
        )
    }
}
