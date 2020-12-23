import UIKit

class WalletCell: UITableViewCell, Reusable {

    var name: String? {
        get { nameLabel.text }
        set { nameLabel.text = newValue }
    }

    var symbol: String? {
        get { symbolLabel.text }
        set { symbolLabel.text = newValue }
    }

    var balance: String? {
        get { balanceLabel.text }
        set { balanceLabel.text = newValue }
    }

    var isDefault: Bool {
        get { overlayView.backgroundColor == .lightGray }
        set { overlayView.backgroundColor = newValue ? .systemGreen : .lightGray }
    }

    var imageTarget: ImageTarget { ImageTarget(imageView: iconImageView, size: Constants.iconImageViewSize) }

    private lazy var overlayView: UIView = .init()
    private lazy var iconImageView: UIImageView = .init()
    private lazy var nameLabel: UILabel = .init()
    private lazy var symbolLabel: UILabel = .init()
    private lazy var balanceLabel: UILabel = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        configureOverlayView()
        configureIconImageView()
        configureNameLabel()
        configureSymbolLabel()
        configureBalanceLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        name = nil
        symbol = nil
        balance = nil
        isDefault = false
    }

    private func configureOverlayView() {
        overlayView.backgroundColor = .lightGray
        overlayView.layer.cornerCurve = .continuous
        overlayView.layer.cornerRadius = Constants.overlayViewCornerRadius
        addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.overlayViewEdgeInsets)
        }
    }

    private func configureIconImageView() {
        iconImageView.layer.cornerRadius = Constants.iconImageViewSize.width / 2
        overlayView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(Constants.iconImageViewLeftTopBottomInset)
            make.size.equalTo(Constants.iconImageViewSize)
        }
    }

    private func configureNameLabel() {
        overlayView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(Constants.iconImageViewRightOffset)
            make.right.equalToSuperview().inset(Constants.contentRightInset)
            make.centerY.equalTo(iconImageView.snp.centerY).offset(-Constants.iconImageViewSize.height / 4)
        }
    }

    private func configureSymbolLabel() {
        overlayView.addSubview(symbolLabel)
        symbolLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(Constants.iconImageViewRightOffset)
            make.centerY.equalTo(iconImageView.snp.centerY).offset(Constants.iconImageViewSize.height / 4)
        }
    }

    private func configureBalanceLabel() {
        balanceLabel.textAlignment = .right
        overlayView.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { make in
            make.left.equalTo(symbolLabel.snp.right).offset(Constants.balanceLeftOffset)
            make.right.equalToSuperview().inset(Constants.contentRightInset)
            make.centerY.equalTo(symbolLabel)
        }
    }
}

private enum Constants {

    static let overlayViewCornerRadius: CGFloat = 16.0
    static let overlayViewEdgeInsets: UIEdgeInsets = .init(top: 4.0, left: 0.0, bottom: 4.0, right: 0.0)

    static let contentRightInset: CGFloat = 8.0

    static let iconImageViewLeftTopBottomInset: CGFloat = 8.0
    static let iconImageViewSize = CGSize(width: 42.0, height: 42.0)
    static let iconImageViewRightOffset: CGFloat = 8.0

    static let nameToPriceLabelsSpacing: CGFloat = 4.0

    static let balanceLeftOffset: CGFloat = 8.0
}
