import Foundation
import PromiseKit

protocol MasterdataService {

    func fetchMasterdata() -> Promise<Masterdata>
}

class DefaultMasterdataService: MasterdataService {

    enum Error: Swift.Error {
        case emptyMasterdata
        case decoding
    }

    init(masterdataDataStore: MasterdataDataStore = Services.masterdataDataStore) {
        self.masterdataDataStore = masterdataDataStore
    }

    func fetchMasterdata() -> Promise<Masterdata> {
        return Promise { seal in
            DispatchQueue.main.async { [unowned self] in
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
    }

    private let masterdataDataStore: MasterdataDataStore
}
