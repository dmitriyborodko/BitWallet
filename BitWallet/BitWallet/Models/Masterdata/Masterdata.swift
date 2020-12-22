import Foundation

struct Masterdata {

    let assets: Assets
}

extension Masterdata {

    init(withDTO dto: MasterdataDTO) {
        self.assets = Assets(withDTO: dto.data.attributes)
    }
}
