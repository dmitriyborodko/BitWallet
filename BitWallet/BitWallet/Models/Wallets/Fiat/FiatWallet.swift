import Foundation

struct FiatWallet: Wallet {

    let type: WalletType = .fiat

    let name: String
    let fiatSymbol: String
    let formattedBalance: String?
    let icon: ImageModel?

    let balance: Double?
}

extension FiatWallet {

    init(withDTO dto: FiatWalletDTO, fiatAttributesDTO: FiatAtttributesDTO?) {
        self.name = dto.attributes.name
        self.fiatSymbol = dto.attributes.fiatSymbol

        let balance = Double(dto.attributes.balance)
        self.balance = balance

        self.formattedBalance = PriceFormatter.format(
            price: balance,
            precision: fiatAttributesDTO?.precision,
            currencySymbol: fiatAttributesDTO?.symbol
        )

        self.icon = ImageModel(
            lightImagePath: fiatAttributesDTO?.lightLogo,
            darkImagePath: fiatAttributesDTO?.darkLogo
        )
    }
}
