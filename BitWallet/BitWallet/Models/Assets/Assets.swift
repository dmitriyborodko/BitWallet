import Foundation

struct Assets {

    let cryptocoins: [Cryptocoin]
    let commodities: [Commodity]
}

extension Assets {

    init(withDTO dto: MasterdataAtttributesDTO) {
        self.cryptocoins = dto.cryptocoins.map(Cryptocoin.init)
        self.commodities = dto.commodities.map(Commodity.init)
    }
}
