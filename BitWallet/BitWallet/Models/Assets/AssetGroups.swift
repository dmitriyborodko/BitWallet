import Foundation

struct AssetGroups {

    let cryptocoins: [Cryptocoin]
    let commodities: [Commodity]
    let fiats: [Fiat]
}

extension AssetGroups {

    init(withDTO dto: MasterdataAtttributesDTO) {
        self.cryptocoins = dto.cryptocoins.map(Cryptocoin.init)
        self.commodities = dto.commodities.map(Commodity.init)
        self.fiats = dto.fiats.compactMap(Fiat.init)
    }
}
