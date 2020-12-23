import Foundation

struct Fiat: AssetUnit {

    let type: AssetType = .fiat

    let symbol: String
    let name: String
    let logo: ImageModel?
    let precision: Int
}

extension Fiat {

    init(withDTO dto: FiatDTO) {
        self.symbol = dto.attributes.symbol
        self.name = dto.attributes.name

        self.logo = ImageModel(
            lightImagePath: dto.attributes.lightLogo,
            darkImagePath: dto.attributes.darkLogo
        )

        self.precision = dto.attributes.precision
    }
}
