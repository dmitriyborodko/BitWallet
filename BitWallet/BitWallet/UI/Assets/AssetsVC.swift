import UIKit
import PromiseKit
import SnapKit

class AssetsVC: UIViewController {

    // MARK: - Interface
    
    override func loadView() {
        view = UIView()

        configureUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadAssets()
    }

    // MARK: - Implementation

    private lazy var titleSegmentedControl: UISegmentedControl = self.makeTitleSegmentedControl()
    private lazy var tableView: UITableView = .init()

    private var state: State = .loading
    private var selectedSegment: Segment { Segment(rawValue: titleSegmentedControl.selectedSegmentIndex) ?? .all }

    private var assetsService: AssetsService
    private var imageService: ImageService

    init(
        assetsService: AssetsService = Services.assetsService,
        imageService: ImageService = Services.imageService
    ) {
        self.assetsService = assetsService
        self.imageService = imageService

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        view.backgroundColor = .systemTeal
        navigationItem.titleView = titleSegmentedControl

        configureTableView()
    }

    private func makeTitleSegmentedControl() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl()

        for segment in Segment.allCases {
            segmentedControl.insertSegment(withTitle: segment.description, at: segment.rawValue, animated: false)
        }

        segmentedControl.selectedSegmentIndex = Segment.all.rawValue

        return segmentedControl
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(self.view.safeAreaInsets)
        }
    }

    private func loadAssets() {
        applyLoadingState()

        firstly {
            assetsService.fetchAssets()
        }.done { [weak self] assets in
            self?.apply(assets: assets)
        }.catch { [weak self] error in
            self?.apply(error: error)
        }
    }

    private func applyLoadingState() {
        
    }

    private func apply(assets: Assets) {

    }

    private func apply(error: Error) {

    }
}

// MARK: - UITableViewDataSource

extension AssetsVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        switch state {
        case .loading:
            return 1

        case .presenting:
            return selectedSegment.numberOfSections

        case .error:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return 1

        case .presenting(let assets):
            return selectedSegment.numberOfAssets(inSection: section, assets: assets)

        case .error:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .loading:
            return tableView.registerAndDequeueReusableCell() as LoadingCell

        case .presenting(let assets):
            return tableView.registerAndDequeueReusableCell() as AssetCell

        case .error(let error):
            return tableView.registerAndDequeueReusableCell() as ErrorCell
        }
    }
}

// MARK: - UITableViewDataSource

extension AssetsVC: UITableViewDelegate {

}

// MARK: -

private enum Segment: Int, CustomStringConvertible, CaseIterable {

    case all = 0
    case cryptocoins
    case metals
    case fiats

    var description: String {
        switch self {
        case .all:
            return "All"

        case .cryptocoins:
            return "Cryptocoins"

        case .metals:
            return "Metals"

        case .fiats:
            return "Fiats"
        }
    }

    var numberOfSections: Int {
        switch self {
        case .all:
            return Segment.allCases.count

        case .cryptocoins, .metals, .fiats:
            return 1
        }
    }

    func numberOfAssets(inSection section: Int, assets: Assets) -> Int {
        switch (self, section) {
        case (.all, 0), (.cryptocoins, 0):
            return assets.cryptocoins.count

        case (.all, 1), (.metals, 0):
            return 0

        case (.all, 2), (.fiats, 0):
            return 0

        default:
            return 0
        }
    }
}

private enum State {

    case loading
    case presenting(assets: Assets)
    case error(description: String)
}
