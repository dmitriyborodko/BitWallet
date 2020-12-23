import Foundation

/// Much more handy to use a DI here, but I just didn't want to add it :-)
enum Services {

    static let imageService: ImageService = DefaultImageService()

    static let masterdataDataStore: MasterdataDataStore = DefaultMasterdataDataStore()
    static let masterdataService: MasterdataService = DefaultMasterdataService()

    static let assetsService: AssetsService = DefaultAssetsService()
    static let walletsService: WalletsService = DefaultWalletsService()
}
