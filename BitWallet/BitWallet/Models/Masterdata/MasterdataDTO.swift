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
    }

    let cryptocoins: [CryptocoinDTO]
    let commodities: [CommodityDTO]
    let fiats: [FiatDTO]
    let cryptocoinWallets: [CryptocoinWalletDTO]
}
