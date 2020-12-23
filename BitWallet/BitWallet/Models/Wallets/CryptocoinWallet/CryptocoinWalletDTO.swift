import Foundation

struct CryptocoinWalletDTO: Decodable {

    private enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case balance
        case cryptocoinID = "cryptocoin_id"
    }

    let name: String
    let symbol: String
    let balance: String
    let cryptocoinID: String
}
