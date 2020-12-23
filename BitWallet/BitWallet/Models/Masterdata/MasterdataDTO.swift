import Foundation

struct MasterdataDTO: Decodable {

    let data: MasterdataDataDTO
}

struct MasterdataDataDTO: Decodable {

    let attributes: MasterdataAtttributesDTO
}

struct MasterdataAtttributesDTO: Decodable {

    private enum CodingKeys: String, CodingKey {
        case cryptocoins
        case commodities
        case fiats
        case cryptocoinWallets = "wallets"
        case commodityWallets = "commodity_wallets"
        case fiatWallets = "fiatwallets"
    }

    let cryptocoins: [CryptocoinDTO]
    let commodities: [CommodityDTO]
    let fiats: [FiatDTO]
    let cryptocoinWallets: [CryptocoinWalletDTO]
    let commodityWallets: [CommodityWalletDTO]
    let fiatWallets: [FiatWalletDTO]
}
