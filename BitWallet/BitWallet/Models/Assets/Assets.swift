import Foundation

struct Assets {

    let cryptocoins: [Cryptocoin]
}

extension Assets {

    init(withDTO dto: MasterdataAtttributesDTO) {
        self.cryptocoins = dto.cryptocoins.map(Cryptocoin.init)
    }
}
