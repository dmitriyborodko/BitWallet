import Foundation
import PromiseKit

protocol WalletsService {

    func fetchWallets() -> Promise<WalletGroups>
}

class DefaultWalletsService: WalletsService {

    // MARK: - Interface

    init(masterdataService: MasterdataService = Services.masterdataService) {
        self.masterdataService = masterdataService
    }

    func fetchWallets() -> Promise<WalletGroups> {
        if let walletsPromise = walletsPromise { return walletsPromise }

        let promise: Promise<WalletGroups> = firstly {
            masterdataService.fetchMasterdata()
        }.map { [unowned self] masterdata in
            walletsPromise = nil
            return masterdata.wallets
        }

        walletsPromise = promise

        return promise
    }

    // MARK: - Implementation

    private let masterdataService: MasterdataService
    private var walletsPromise: Promise<WalletGroups>?
}
