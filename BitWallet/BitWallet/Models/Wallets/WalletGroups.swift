import Foundation

struct WalletGroups {

    let cryptocoinWallets: [CryptocoinWallet]
    let commodityWallets: [CommodityWallet]
//    let fiats: [Fiat]
}

extension WalletGroups {

    init(withDTO dto: MasterdataAtttributesDTO) {
        self.cryptocoinWallets = dto.cryptocoinWallets
            .map { walletDTO in
                CryptocoinWallet(
                    withDTO: walletDTO,
                    cryptocoinAttributesDTO: dto.cryptocoins
                        .first { $0.id == walletDTO.attributes.cryptocoinID }?
                        .attributes
                )
            }

        self.commodityWallets = dto.commodityWallets
            .map { walletDTO in
                CommodityWallet(
                    withDTO: walletDTO,
                    commodityAttributesDTO: dto.commodities
                        .first { $0.id == walletDTO.attributes.cryptocoinID }?
                        .attributes
                )
            }

//        self.fiats = dto.fiats.map(Fiat.init)
    }
}
