import Foundation

struct FiatDTO: Decodable {

    let id: String
    let attributes: FiatAtttributesDTO
}

struct FiatAtttributesDTO: Decodable {

    private enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case lightLogo = "logo"
        case darkLogo = "logo_dark"
        case hasWallets = "has_wallets"
    }

    let symbol: String
    let name: String

    /// Here we save Strings instead of URLs because they may not be parsed if URL is not valid,
    /// so it will throw DecodingError
    let lightLogo: String?
    let darkLogo: String?
    let hasWallets: Bool
}
