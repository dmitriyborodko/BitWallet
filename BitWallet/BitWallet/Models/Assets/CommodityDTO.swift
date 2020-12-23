import Foundation

struct CommodityDTO: Decodable {

    let attributes: CommodityAtttributesDTO
}

struct CommodityAtttributesDTO: Decodable {

    private enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case averagePrice = "avg_price"
        case lightLogo = "logo"
        case darkLogo = "logo_dark"
        case fiatPricePrecision = "precision_for_fiat_price"
    }

    let symbol: String
    let name: String
    let averagePrice: String

    /// Here we save Strings instead of URLs because they may not be parsed if URL is not valid,
    /// so it will throw DecodingError
    let lightLogo: String?
    let darkLogo: String?

    let fiatPricePrecision: Int
}
