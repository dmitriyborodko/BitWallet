import Foundation

protocol MasterdataDataStore {

    func storeMasterdata(_ masterdata: Masterdata)
    func restoreMasterdata() -> Masterdata?
}

class DefaultMasterdataDataStore: MasterdataDataStore {

    private var masterdata: Masterdata?

    func storeMasterdata(_ masterdata: Masterdata) {
        self.masterdata = masterdata
    }

    func restoreMasterdata() -> Masterdata? {
        return masterdata
    }
}
