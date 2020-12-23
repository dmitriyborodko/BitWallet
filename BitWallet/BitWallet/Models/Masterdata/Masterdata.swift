import Foundation

struct Masterdata {

    let assets: Assets
    let wallets: Wallets
}

extension Masterdata {

    init(withDTO dto: MasterdataDTO) {
        self.assets = Assets(withDTO: dto.data.attributes)
        self.wallets = Wallets(withDTO: dto.data.attributes)
    }
}
