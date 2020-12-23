import Foundation

protocol Asset {

    var type: AssetType { get }
}

enum AssetType: Int, CaseIterable {

    case cryptocoin = 0
    case commodity
    case fiat

    static var `default`: Self = .cryptocoin
}
