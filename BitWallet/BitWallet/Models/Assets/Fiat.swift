import Foundation

struct Fiat: AssetUnit {

    let type: AssetType = .fiat

    let symbol: String
    let name: String
    let logo: ImageModel?
}

extension Fiat {

    init(withDTO dto: FiatDTO) {
        self.symbol = dto.attributes.symbol
        self.name = dto.attributes.name

        self.logo = ImageModel(
            lightImagePath: dto.attributes.lightLogo,
            darkImagePath: dto.attributes.darkLogo
        )
    }
}
