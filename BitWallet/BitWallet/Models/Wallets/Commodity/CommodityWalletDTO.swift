import Foundation

struct CommodityWalletDTO: Decodable {

    let id: String
    let attributes: CommodityWalletAttributesDTO
}

struct CommodityWalletAttributesDTO: Decodable {

    private enum CodingKeys: String, CodingKey {
        case name
        case cryptocoinSymbol = "cryptocoin_symbol"
        case balance
        case cryptocoinID = "cryptocoin_id"
    }

    let name: String
    let cryptocoinSymbol: String
    let balance: String
    let cryptocoinID: String
}
