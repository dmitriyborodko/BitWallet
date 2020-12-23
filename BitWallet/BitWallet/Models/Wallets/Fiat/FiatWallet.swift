import Foundation

struct FiatWallet: Wallet {

    let name: String
    let fiatSymbol: String
    let balance: String?
    let icon: ImageModel?
}

extension FiatWallet {

    init(withDTO dto: FiatWalletDTO, fiatAttributesDTO: FiatAtttributesDTO?) {
        self.name = dto.attributes.name
        self.fiatSymbol = dto.attributes.fiatSymbol

        self.balance = PriceFormatter.format(
            price: dto.attributes.balance,
            precision: fiatAttributesDTO?.precision,
            currencySymbol: fiatAttributesDTO?.symbol
        )

        self.icon = ImageModel(
            lightImagePath: fiatAttributesDTO?.lightLogo,
            darkImagePath: fiatAttributesDTO?.darkLogo
        )
    }
}
