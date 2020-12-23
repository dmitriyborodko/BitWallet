import Foundation

struct CryptocoinWalletDTO: Decodable {

    let id: String
    let attributes: CryptocoinWalletAttributesDTO
}

struct CryptocoinWalletAttributesDTO: Decodable {

    private enum CodingKeys: String, CodingKey {
        case name
        case cryptocoinSymbol = "cryptocoin_symbol"
        case balance
        case cryptocoinID = "cryptocoin_id"
        case isDeleted = "deleted"
        case isDefault = "is_default"
    }

    let name: String
    let cryptocoinSymbol: String
    let balance: String
    let cryptocoinID: String
    let isDeleted: Bool
    let isDefault: Bool
}
