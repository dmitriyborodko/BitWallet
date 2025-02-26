import Foundation

struct CommodityWallet: Wallet {

    let type: WalletType = .commodity

    let name: String
    let cryptocoinSymbol: String
    let formattedBalance: String?
    let icon: ImageModel?
    let isDefault: Bool

    let balance: Double?
}

extension CommodityWallet {

    init?(withDTO dto: CommodityWalletDTO, commodityAttributesDTO: CommodityAtttributesDTO?) {
        guard !dto.attributes.isDeleted else { return nil }

        self.name = dto.attributes.name
        self.cryptocoinSymbol = dto.attributes.cryptocoinSymbol

        let balance = Double(dto.attributes.balance)
        self.balance = balance

        self.formattedBalance = PriceFormatter.format(
            price: balance,
            precision: commodityAttributesDTO?.precisionForCoins,
            currencySymbol: commodityAttributesDTO?.symbol
        )

        self.icon = ImageModel(
            lightImagePath: commodityAttributesDTO?.lightLogo,
            darkImagePath: commodityAttributesDTO?.darkLogo
        )

        self.isDefault = dto.attributes.isDefault
    }
}
