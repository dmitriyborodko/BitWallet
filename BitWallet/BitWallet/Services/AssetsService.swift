import Foundation
import PromiseKit

protocol AssetsService {

    func fetchAssets() -> Promise<AssetGroups>
}

class DefaultAssetsService: AssetsService {

    private let masterdataService: MasterdataService
    private var assetsPromise: Promise<AssetGroups>?

    init(masterdataService: MasterdataService = Services.masterdataService) {
        self.masterdataService = masterdataService
    }

    func fetchAssets() -> Promise<AssetGroups> {
        if let assetsPromise = assetsPromise {
            return assetsPromise
        }

        let promise: Promise<AssetGroups> = firstly {
            masterdataService.fetchMasterdata()
        }.map { [unowned self] masterdata in
            assetsPromise = nil
            return masterdata.assets
        }

        assetsPromise = promise

        return promise
    }
}
