import UIKit
import PromiseKit
import SnapKit

class WalletsVC: UIViewController {

    // MARK: - Interface

    override func loadView() {
        view = UIView()

        configureUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadWalletGroups()
    }

    // MARK: - Implementation

    private lazy var tableView: UITableView = .init()

    private var state: State = .loading {
        didSet { reloadTableView() }
    }

    private var walletsService: WalletsService
    private var imageService: ImageService

    init(
        walletsService: WalletsService = Services.walletsService,
        imageService: ImageService = Services.imageService
    ) {
        self.walletsService = walletsService
        self.imageService = imageService

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard Theme.current != previousTraitCollection?.theme else { return }

        reloadTableView()
    }

    private func configureUI() {
        view.backgroundColor = .systemIndigo
        navigationItem.title = "What a rich boy!"

        configureTableView()
    }

    private func configureTableView() {
        tableView.delegate = self
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

    private func loadWalletGroups() {
        applyLoadingState()

        firstly {
            walletsService.fetchWallets()
        }.done { [weak self] walletGroups in
            self?.apply(walletGroups: walletGroups)
        }.catch { [weak self] error in
            self?.apply(error: error)
        }
    }

    private func applyLoadingState() {

    }

    private func apply(walletGroups: WalletGroups) {
        state = .presenting(walletGroups: walletGroups)
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

extension WalletsVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        switch state {
        case .loading:
            return 1

        case .presenting(let walletGroups):
            return walletGroups.count

        case .error:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return 1

        case .presenting(let walletGroups):
            return walletGroups.wallets(forSection: section)?.count ?? 0

        case .error:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .loading:
            return tableView.registerAndDequeueReusableCell() as LoadingCell

        case .presenting(let walletGroups):
            guard
                let wallet = walletGroups.wallets(forSection: indexPath.section)?[safe: indexPath.row]
            else { return .init() }

            let cell = tableView.registerAndDequeueReusableCell() as WalletCell
            configureWalletCell(cell, with: wallet)
            return cell

        case .error(let error):
            let cell = tableView.registerAndDequeueReusableCell() as ErrorCell
            cell.title = error
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch state {
        case .loading, .error:
            return nil

        case .presenting(let walletGroups):
            let header = tableView.registerAndDequeueReusableHeaderFooterView() as AssetHeaderView
            header.title = walletGroups.headerTitle(forSection: section)
            return header
        }
    }

    private func configureWalletCell(_ cell: WalletCell, with wallet: WalletUnit) {
        switch wallet {
        case let wallet as CryptocoinWallet:
            cell.name = wallet.name
            cell.symbol = wallet.cryptocoinSymbol
            cell.balance = wallet.balance

            imageService.fetch(wallet.icon?.url, for: cell.imageTarget, placeholder: #imageLiteral(resourceName: "camera"))

//        case let asset as Commodity:
//            cell.name = asset.name
//            cell.price = asset.averagePrice
//
//            imageService.fetch(asset.logo?.url, for: cell.imageTarget,  placeholder: #imageLiteral(resourceName: "camera"))
//
//        case let asset as Fiat:
//            cell.name = asset.name
//
//            imageService.fetch(asset.logo?.url, for: cell.imageTarget,  placeholder: #imageLiteral(resourceName: "camera"))

        default: break
        }
    }
}

// MARK: - UITableViewDataSource

extension WalletsVC: UITableViewDelegate {

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
            return "Crypto"

        case .metals:
            return "Metals"

        case .fiats:
            return "Fiats"
        }
    }

    var numberOfSections: Int {
        switch self {
        case .all:
            return 3

        case .cryptocoins, .metals, .fiats:
            return 1
        }
    }

    func numberOfAssets(inSection section: Int, assets: Assets) -> Int {
        switch (self, section) {
        case (.all, 0), (.cryptocoins, 0):
            return assets.cryptocoins.count

        case (.all, 1), (.metals, 0):
            return assets.commodities.count

        case (.all, 2), (.fiats, 0):
            return assets.fiats.count

        default:
            return 0
        }
    }

    func asset(with assets: Assets, indexPath: IndexPath) -> AssetUnit? {
        switch (self, indexPath.section) {
        case (.all, 0), (.cryptocoins, 0):
            return assets.cryptocoins[safe: indexPath.row]

        case (.all, 1), (.metals, 0):
            return assets.commodities[safe: indexPath.row]

        case (.all, 2), (.fiats, 0):
            return assets.fiats[safe: indexPath.row]

        default:
            return nil
        }
    }

    func headerTitle(forSection section: Int) -> String? {
        switch (self, section) {
        case (.all, 0), (.cryptocoins, 0):
            return "Cryptocoins"

        case (.all, 1), (.metals, 0):
            return "Metals"

        case (.all, 2), (.fiats, 0):
            return "Fiats"

        default:
            return nil
        }
    }
}

private enum State {

    case loading
    case presenting(walletGroups: WalletGroups)
    case error(description: String)
}

private extension WalletGroups {

    var count: Int { 3 }

    func wallets(forSection section: Int) -> [WalletUnit]? {
        switch section {
        case 0:
            return cryptocoinWallets

        default:
            return nil
        }
    }

    func headerTitle(forSection section: Int) -> String? {
        switch section {
        case 0:
            return "Cryptocoin Wallets"

        default:
            return ""
        }
    }
}

private enum Constants {

    static let animationDuration: TimeInterval = 0.2
}
