import Foundation
import PromiseKit

protocol MasterdataService {

    func fetchMasterdata() -> Promise<Masterdata>
}

class DefaultMasterdataService: MasterdataService {

    // MARK: - Interface

    enum Error: Swift.Error {
        case emptyMasterdata
        case decoding
    }

    init(masterdataDataStore: MasterdataDataStore = Services.masterdataDataStore) {
        self.masterdataDataStore = masterdataDataStore
    }

    func fetchMasterdata() -> Promise<Masterdata> {
        if let masterdataPromise = masterdataPromise {
            return masterdataPromise
        }

        let promise: Promise<Masterdata> = Promise { seal in
            DispatchQueue.main.async { [unowned self] in
                defer { self.masterdataPromise = nil }

                if let masterdata = self.masterdataDataStore.restoreMasterdata() {
                    seal.fulfill(masterdata)
                    return
                }

                guard let path = Bundle.main.path(forResource: "Mastrerdata", ofType: "json") else {
                    seal.reject(Error.emptyMasterdata)
                    return
                }

                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    let masterdataDTO = try JSONDecoder().decode(MasterdataDTO.self, from: data)
                    let masterdata = Masterdata(withDTO: masterdataDTO)

                    self.masterdataDataStore.storeMasterdata(masterdata)

                    seal.fulfill(masterdata)
                } catch let error {
                    seal.reject(error)
                }
            }
        }

        masterdataPromise = promise

        return promise
    }

    // MARK: - Implementation

    private var masterdataPromise: Promise<Masterdata>?
    private let masterdataDataStore: MasterdataDataStore
}
