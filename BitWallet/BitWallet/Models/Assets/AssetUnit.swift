import Foundation

protocol AssetUnit {

    var type: AssetType { get }
}

enum AssetType: CaseIterable {

    case cryptocoin
    case commodity
//    case fiat
}
