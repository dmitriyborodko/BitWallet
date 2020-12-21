import Foundation

protocol MasterdataDataStore {

    func storeMasterdata(_ masterdata: Masterdata)
    func restoreMasterdata() -> Masterdata?
}

class DefaultMasterdataDataStore: MasterdataDataStore {

    // MARK: - Interface

    func storeMasterdata(_ masterdata: Masterdata) {
        self.masterdata = masterdata
    }

    func restoreMasterdata() -> Masterdata? {
        return masterdata
    }

    // MARK: - Implementation

    private var masterdata: Masterdata?
}
