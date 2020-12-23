import Foundation

enum Services {

    // MARK: - Interface

    static let imageService: ImageService = DefaultImageService()

    static let masterdataDataStore: MasterdataDataStore = DefaultMasterdataDataStore()
    static let masterdataService: MasterdataService = DefaultMasterdataService()

    static let assetsService: AssetsService = DefaultAssetsService()
    static let walletsService: WalletsService = DefaultWalletsService()
}
