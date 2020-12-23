import Foundation

struct Wallets {

    let cryptocoinWallets: [CryptocoinWallet]
//    let commodities: [Commodity]
//    let fiats: [Fiat]
}

extension Wallets {

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

//        self.commodities = dto.commodities.map(Commodity.init)
//        self.fiats = dto.fiats.map(Fiat.init)
    }
}
