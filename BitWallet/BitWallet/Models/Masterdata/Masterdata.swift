import Foundation

struct Masterdata {

    let assets: AssetGroups
    let wallets: WalletGroups
}

extension Masterdata {

    init(withDTO dto: MasterdataDTO) {
        self.assets = AssetGroups(withDTO: dto.data.attributes)
        self.wallets = WalletGroups(withDTO: dto.data.attributes)
    }
}
