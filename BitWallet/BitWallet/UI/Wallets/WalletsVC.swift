import UIKit
import PromiseKit
import SnapKit

class WalletsVC: UIViewController {

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

    override func loadView() {
        view = UIView()

        configureUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadWalletGroups()
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
            walletsService.fetchWalletGroups()
        }.done { [weak self] walletGroups in
            self?.apply(walletGroups: walletGroups)
        }.catch { [weak self] error in
            self?.apply(error: error)
        }
    }

    private func applyLoadingState() {
        state = .loading
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

        case .presenting:
            return WalletGroups.count

        case .error:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return 1

        case .presenting(let walletGroups):
            return WalletType(rawValue: section).flatMap(walletGroups.wallets)?.count ?? 0

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
                let type = WalletType(rawValue: indexPath.section),
                let wallet = walletGroups.wallets(for: type)[safe: indexPath.row]
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

    private func configureWalletCell(_ cell: WalletCell, with wallet: Wallet) {
        switch wallet {
        case let wallet as CryptocoinWallet:
            cell.name = wallet.name
            cell.symbol = wallet.cryptocoinSymbol
            cell.balance = wallet.balance

            imageService.fetch(wallet.icon?.url, for: cell.imageTarget, placeholder: #imageLiteral(resourceName: "camera"))

        case let wallet as CommodityWallet:
            cell.name = wallet.name
            cell.symbol = wallet.cryptocoinSymbol
            cell.balance = wallet.balance

            imageService.fetch(wallet.icon?.url, for: cell.imageTarget, placeholder: #imageLiteral(resourceName: "camera"))

        case let wallet as FiatWallet:
            cell.name = wallet.name
            cell.symbol = wallet.fiatSymbol
            cell.balance = wallet.balance

            imageService.fetch(wallet.icon?.url, for: cell.imageTarget, placeholder: #imageLiteral(resourceName: "camera"))

        default:
            break
        }
    }
}

// MARK: - UITableViewDelegate

extension WalletsVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch state {
        case .loading, .error:
            return nil

        case .presenting(let walletGroups):
            let header = tableView.registerAndDequeueReusableHeaderFooterView() as HeaderView
            header.title = WalletType(rawValue: section).flatMap(walletGroups.headerTitle)
            return header
        }
    }
}

// MARK: -

private enum State {

    case loading
    case presenting(walletGroups: WalletGroups)
    case error(description: String)
}

private extension WalletGroups {

    static var count: Int { 3 }

    func wallets(for type: WalletType) -> [Wallet] {
        switch type {
        case .cryptocoin:
            return cryptocoinWallets

        case .commodity:
            return commodityWallets

        case .fiat:
            return fiatWallets
        }
    }

    func headerTitle(for type: WalletType) -> String {
        switch type {
        case .cryptocoin:
            return "Cryptocoin Wallets"

        case .commodity:
            return "Commodity Wallets"

        case .fiat:
            return "Fiat Wallets"
        }
    }
}

private enum Constants {

    static let animationDuration: TimeInterval = 0.2
}
