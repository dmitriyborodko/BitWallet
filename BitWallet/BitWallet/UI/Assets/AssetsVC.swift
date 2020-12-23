import UIKit
import PromiseKit
import SnapKit

class AssetsVC: UIViewController {

    private lazy var titleSegmentedControl: UISegmentedControl = self.makeTitleSegmentedControl()
    private lazy var tableView: UITableView = .init()

    private var state: State = .loading {
        didSet { reloadTableView() }
    }
    private var selectedAssetType: AssetType {
        AssetType(rawValue: titleSegmentedControl.selectedSegmentIndex) ?? .default
    }

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

    override func loadView() {
        view = UIView()

        configureUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadAssets()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard Theme.current != previousTraitCollection?.theme else { return }

        reloadTableView()
    }

    @objc private func onTitleSegmentedControlValueChanged() {
        reloadTableView()
    }

    private func configureUI() {
        view.backgroundColor = .systemTeal
        navigationItem.titleView = titleSegmentedControl

        configureTableView()
    }

    private func makeTitleSegmentedControl() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl()

        for (index, type) in AssetType.allCases.enumerated() {
            segmentedControl.insertSegment(
                withTitle: AssetGroups.segmentTitle(for: type),
                at: index,
                animated: false
            )
        }

        segmentedControl.selectedSegmentIndex = AssetType.default.rawValue

        segmentedControl.addTarget(
            self,
            action: #selector(onTitleSegmentedControlValueChanged),
            for: .valueChanged
        )

        return segmentedControl
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(self.view.safeAreaInsets)
        }
    }

    private func reloadTableView() {
        UIView.transition(
            with: tableView,
            duration: 0.2,
            options: [.transitionCrossDissolve, .curveEaseInOut],
            animations: { self.tableView.reloadData() }
        )
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
        state = .loading
    }

    private func apply(assets: AssetGroups) {
        state = .presenting(assets: assets)
    }

    private func apply(error: Error) {
        guard let error = error as? DefaultMasterdataService.Error else {
            state = .error(description: "Unknown error appeared")
            return
        }

        switch error {
        case .emptyMasterdata:
            state = .error(description: "No masterdata found")

        case .decoding:
            state = .error(description: "Masterdata was corrupted")
        }
    }
}

// MARK: - UITableViewDataSource

extension AssetsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return 1

        case .presenting(let assetGroups):
            return assetGroups.assets(for: selectedAssetType)?.count ?? 0

        case .error:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .loading:
            return tableView.registerAndDequeueReusableCell() as LoadingCell

        case .presenting(let assetGroups):
            guard
                let asset = assetGroups.assets(for: selectedAssetType)?[safe: indexPath.row]
            else { return .init() }

            let cell = tableView.registerAndDequeueReusableCell() as AssetCell
            configureAssetCell(cell, with: asset)
            return cell

        case .error(let error):
            let cell = tableView.registerAndDequeueReusableCell() as ErrorCell
            cell.title = error
            return cell
        }
    }

    private func configureAssetCell(_ cell: AssetCell, with asset: Asset) {
        switch asset {
        case let asset as Cryptocoin:
            cell.name = asset.name
            cell.price = asset.averagePrice

            imageService.fetch(asset.logo?.url, for: cell.imageTarget,  placeholder: #imageLiteral(resourceName: "camera"))

        case let asset as Commodity:
            cell.name = asset.name
            cell.price = asset.averagePrice

            imageService.fetch(asset.logo?.url, for: cell.imageTarget,  placeholder: #imageLiteral(resourceName: "camera"))

        case let asset as Fiat:
            cell.name = asset.name

            imageService.fetch(asset.logo?.url, for: cell.imageTarget,  placeholder: #imageLiteral(resourceName: "camera"))

        default:
            break
        }
    }
}

private extension AssetGroups {

    static var count: Int { 3 }

    static func segmentTitle(for assetType: AssetType) -> String {
        switch assetType {
        case .cryptocoin:
            return "Crypto"

        case .commodity:
            return "Metals"

        case .fiat:
            return "Fiats"
        }
    }

    func assets(for assetType: AssetType) -> [Asset]? {
        switch assetType {
        case .cryptocoin:
            return cryptocoins

        case .commodity:
            return commodities

        case .fiat:
            return fiats
        }
    }
}

private enum State {

    case loading
    case presenting(assets: AssetGroups)
    case error(description: String)
}

private enum Constants {

    static let animationDuration: TimeInterval = 0.2
}
