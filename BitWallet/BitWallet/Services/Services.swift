import Foundation

enum Services {

    // MARK: - Interface

    static let imageService: ImageService = DefaultImageService()

    static let masterdataDataStore: MasterdataDataStore = DefaultMasterdataDataStore()
    static let masterdataService: MasterdataService = DefaultMasterdataService()
}
