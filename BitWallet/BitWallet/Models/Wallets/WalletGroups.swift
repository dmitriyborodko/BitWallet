import Foundation

struct WalletGroups {

    let cryptocoinWallets: [CryptocoinWallet]
    let commodityWallets: [CommodityWallet]
    let fiatWallets: [FiatWallet]
}

extension WalletGroups {

    init(withDTO dto: MasterdataAtttributesDTO) {
        self.cryptocoinWallets = dto.cryptocoinWallets
            .compactMap { walletDTO in
                CryptocoinWallet(
                    withDTO: walletDTO,
                    cryptocoinAttributesDTO: dto.cryptocoins
                        .first { $0.id == walletDTO.attributes.cryptocoinID }?
                        .attributes
                )
            }.sorted(by: { PriceFormatter.comparePrices(left: $0.balance, right: $1.balance) })

        self.commodityWallets = dto.commodityWallets
            .compactMap { walletDTO in
                CommodityWallet(
                    withDTO: walletDTO,
                    commodityAttributesDTO: dto.commodities
                        .first { $0.id == walletDTO.attributes.cryptocoinID }?
                        .attributes
                )
            }.sorted(by: { PriceFormatter.comparePrices(left: $0.balance, right: $1.balance) })

        self.fiatWallets = dto.fiatWallets
            .map { walletDTO in
                FiatWallet(
                    withDTO: walletDTO,
                    fiatAttributesDTO: dto.fiats
                        .first { $0.id == walletDTO.attributes.fiatID }?
                        .attributes
                )
            }.sorted(by: { PriceFormatter.comparePrices(left: $0.balance, right: $1.balance) })
    }
}
