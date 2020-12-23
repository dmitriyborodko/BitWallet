import Foundation

struct FiatWalletDTO: Decodable {

    let id: String
    let attributes: FiatWalletAttributesDTO
}

struct FiatWalletAttributesDTO: Decodable {

    private enum CodingKeys: String, CodingKey {
        case name
        case fiatSymbol = "fiat_symbol"
        case balance
        case fiatID = "fiat_id"
    }

    let name: String
    let fiatSymbol: String
    let balance: String
    let fiatID: String
}
