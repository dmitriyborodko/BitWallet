import Foundation
import PromiseKit

protocol MasterdataService {

    func fetchMasterdata() -> Promise<Masterdata>
}

class DefaultMasterdataService: MasterdataService {

    // MARK: - Interface

    init(masterdataDataStore: MasterdataDataStore = Services.masterdataDataStore) {
        self.masterdataDataStore = masterdataDataStore
    }

    func fetchMasterdata() -> Promise<Masterdata> {
        return Promise.value(Masterdata())
    }

    // MARK: - Implementation

    private let masterdataDataStore: MasterdataDataStore


}
