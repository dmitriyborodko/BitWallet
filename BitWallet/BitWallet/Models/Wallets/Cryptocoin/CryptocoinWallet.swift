import Foundation

struct CryptocoinWallet: Wallet {

    let type: WalletType = .cryptocoin

    let name: String
    let cryptocoinSymbol: String
    let formattedBalance: String?
    let icon: ImageModel?
    let isDefault: Bool

    let balance: Double?
}

extension CryptocoinWallet {

    init?(withDTO dto: CryptocoinWalletDTO, cryptocoinAttributesDTO: CryptocoinAttributesDTO?) {
        guard !dto.attributes.isDeleted else { return nil }

        self.name = dto.attributes.name
        self.cryptocoinSymbol = dto.attributes.cryptocoinSymbol

        let balance = Double(dto.attributes.balance)
        self.balance = balance

        self.formattedBalance = PriceFormatter.format(
            price: balance,
            precision: cryptocoinAttributesDTO?.precisionForCoins,
            currencySymbol: cryptocoinAttributesDTO?.symbol
        )

        self.icon = ImageModel(
            lightImagePath: cryptocoinAttributesDTO?.lightLogo,
            darkImagePath: cryptocoinAttributesDTO?.darkLogo
        )

        self.isDefault = dto.attributes.isDefault
    }
}
