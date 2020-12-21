import Foundation

struct MasterdataDTO: Decodable {

    let data: MasterdataDataDTO
}

struct MasterdataDataDTO: Decodable {

    let attributes: MasterdataAtttributesDTO
}

struct MasterdataAtttributesDTO: Decodable {

    let cryptocoins: [CryptocoinDTO]
}
