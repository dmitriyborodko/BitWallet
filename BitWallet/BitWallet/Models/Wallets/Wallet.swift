import Foundation

/// The fact that these wallets are identical is a mere coincidence.
/// We could move all their properties into this protocol and work with them as just a Wallet,
/// but in a real project those wallets would have different design for sure,
/// and we would have to change many many places.
protocol Wallet {

    var type: WalletType { get }
}

enum WalletType: Int, CaseIterable {

    case cryptocoin = 0
    case commodity
    case fiat

    static var `default`: Self = .cryptocoin
}
