import Foundation

struct CommodityDTO: Decodable {

    let id: String
    let attributes: CommodityAtttributesDTO
}

struct CommodityAtttributesDTO: Decodable {

    private enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case averagePrice = "avg_price"
        case lightLogo = "logo"
        case darkLogo = "logo_dark"
        case precisionForFiatPrice = "precision_for_fiat_price"
        case precisionForCoins = "precision_for_coins"
    }

    let symbol: String
    let name: String
    let averagePrice: String

    /// Here we save Strings instead of URLs because they may not be parsed if URL is not valid,
    /// so it will throw DecodingError
    let lightLogo: String?
    let darkLogo: String?

    let precisionForFiatPrice: Int
    let precisionForCoins: Int
}
