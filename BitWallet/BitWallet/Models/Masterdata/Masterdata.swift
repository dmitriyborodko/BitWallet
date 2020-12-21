import Foundation

struct Masterdata {

    let cryptocoins: [Cryptocoin]
}

extension Masterdata {

    init(withDTO dto: MasterdataDTO) {
        self.cryptocoins = dto.data.attributes.cryptocoins.map(Cryptocoin.init)
    }
}
