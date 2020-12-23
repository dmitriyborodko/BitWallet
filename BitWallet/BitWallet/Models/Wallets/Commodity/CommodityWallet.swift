import Foundation

struct CommodityWallet: Wallet {

    let type: WalletType = .commodity

    let name: String
    let cryptocoinSymbol: String
    let balance: String?
    let icon: ImageModel?
}

extension CommodityWallet {

    init(withDTO dto: CommodityWalletDTO, commodityAttributesDTO: CommodityAtttributesDTO?) {
        self.name = dto.attributes.name
        self.cryptocoinSymbol = dto.attributes.cryptocoinSymbol

        self.balance = PriceFormatter.format(
            price: dto.attributes.balance,
            precision: commodityAttributesDTO?.precisionForCoins,
            currencySymbol: commodityAttributesDTO?.symbol
        )

        self.icon = ImageModel(
            lightImagePath: commodityAttributesDTO?.lightLogo,
            darkImagePath: commodityAttributesDTO?.darkLogo
        )
    }
}
