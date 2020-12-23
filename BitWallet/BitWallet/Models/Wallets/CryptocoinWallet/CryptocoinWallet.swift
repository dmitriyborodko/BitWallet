import Foundation

struct CryptocoinWallet: WalletUnit {

    let name: String
    let symbol: String
    let balance: String?
    let icon: ImageModel?
}

extension CryptocoinWallet {

    init(withDTO dto: CryptocoinWalletDTO, cryptocoinAttributesDTO: CryptocoinAttributesDTO?) {
        self.name = dto.name
        self.symbol = dto.symbol

        self.balance = PriceFormatter.format(
            price: dto.balance,
            precision: nil,
            currencySymbol: cryptocoinAttributesDTO?.symbol
        )

        self.icon = ImageModel(
            lightImagePath: cryptocoinAttributesDTO?.lightLogo,
            darkImagePath: cryptocoinAttributesDTO?.darkLogo
        )
    }
}
