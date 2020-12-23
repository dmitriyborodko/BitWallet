import Foundation

struct CryptocoinWallet: WalletUnit {

    let name: String
    let cryptocoinSymbol: String
    let balance: String?
    let icon: ImageModel?
}

extension CryptocoinWallet {

    init(withDTO dto: CryptocoinWalletDTO, cryptocoinAttributesDTO: CryptocoinAttributesDTO?) {
        self.name = dto.attributes.name
        self.cryptocoinSymbol = dto.attributes.cryptocoinSymbol

        self.balance = PriceFormatter.format(
            price: dto.attributes.balance,
            precision: cryptocoinAttributesDTO?.precisionForCoins,
            currencySymbol: cryptocoinSymbol
        )

        self.icon = ImageModel(
            lightImagePath: cryptocoinAttributesDTO?.lightLogo,
            darkImagePath: cryptocoinAttributesDTO?.darkLogo
        )
    }
}
