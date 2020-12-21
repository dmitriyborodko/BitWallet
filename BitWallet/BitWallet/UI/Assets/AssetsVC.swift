import UIKit

class AssetsVC: UIViewController {

    // MARK: - Interface
    
    override func loadView() {
        view = UIView()

        view.backgroundColor = .systemTeal
        navigationItem.titleView = titleSegmentedControl
    }

    // MARK: - Implementation

    private lazy var titleSegmentedControl = self.makeTitleSegmentedControl()

    private var masterdataService: MasterdataService
    private var imageService: ImageService

    init(
        masterdataService: MasterdataService = Services.masterdataService,
        imageService: ImageService = Services.imageService
    ) {
        self.masterdataService = masterdataService
        self.imageService = imageService

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeTitleSegmentedControl() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl()

        segmentedControl.insertSegment(withTitle: "All", at: Constants.allSegmentIndex, animated: false)
        segmentedControl.insertSegment(withTitle: "Cryptocoins", at: Constants.cryptocoinsSegmentIndex, animated: false)
        segmentedControl.insertSegment(withTitle: "Metals", at: Constants.commoditiesSegmentIndex, animated: false)
        segmentedControl.insertSegment(withTitle: "Fiats", at: Constants.fiatsSegmentIndex, animated: false)

        return segmentedControl
    }
}

private enum Constants {

    static let allSegmentIndex: Int = 0
    static let cryptocoinsSegmentIndex: Int = 1
    static let commoditiesSegmentIndex: Int = 2
    static let fiatsSegmentIndex: Int = 3
}
