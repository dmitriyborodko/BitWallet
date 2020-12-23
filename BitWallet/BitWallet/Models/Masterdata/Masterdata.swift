import Foundation

struct Masterdata {

    let assets: Assets
    let wallets: WalletGroups
}

extension Masterdata {

    init(withDTO dto: MasterdataDTO) {
        self.assets = Assets(withDTO: dto.data.attributes)
        self.wallets = WalletGroups(withDTO: dto.data.attributes)
    }
}
