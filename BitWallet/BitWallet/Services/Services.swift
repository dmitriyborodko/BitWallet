import Foundation

enum Services {

    // MARK: - Interface

    static let imageService: ImageService = DefaultImageService()
    static let masterdataService: MasterdataService = DefaultMasterdataService()
}
