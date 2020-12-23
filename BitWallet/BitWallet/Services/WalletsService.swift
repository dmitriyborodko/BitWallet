import Foundation
import PromiseKit

protocol WalletsService {

    func fetchAssets() -> Promise<Assets>
}

class DefaultWalletsService: WalletsService {

    // MARK: - Interface

    init(masterdataService: MasterdataService = Services.masterdataService) {
        self.masterdataService = masterdataService
    }

    func fetchAssets() -> Promise<Assets> {
        if let assetsPromise = assetsPromise {
            return assetsPromise
        }

        let promise: Promise<Assets> = firstly {
            masterdataService.fetchMasterdata()
        }.map { [unowned self] masterdata in
            assetsPromise = nil
            return masterdata.assets
        }

        assetsPromise = promise

        return promise
    }

    // MARK: - Implementation

    private let masterdataService: MasterdataService
    private var assetsPromise: Promise<Assets>?
}
