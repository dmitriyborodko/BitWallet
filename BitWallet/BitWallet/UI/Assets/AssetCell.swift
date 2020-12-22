import UIKit

class AssetCell: UITableViewCell, Reusable {

    var iconTarget: ImageTarget { .init(imageView: iconImageView, size: Constants.iconImageViewSize) }

    var name: String? {
        get { nameLabel.text }
        set { nameLabel.text = newValue }
    }

    var price: String? {
        get { priceLabel.text }
        set { priceLabel.text = newValue }
    }

    private lazy var overlayView: UIView = .init()
    private lazy var iconImageView: UIImageView = .init()
    private lazy var nameLabel: UILabel = .init()
    private lazy var priceLabel: UILabel = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        configureOverlayView()
        configureIconImageView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureOverlayView() {
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
        overlayView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(Constants.iconImageViewLeftTopBottomInset)
            make.size.equalTo(Constants.iconImageViewSize)
        }
    }
}

private enum Constants {

    static var overlayViewCornerRadius: CGFloat = 4.0
    static var overlayViewEdgeInsets: UIEdgeInsets = .init(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)

    static var iconImageViewLeftTopBottomInset: CGFloat = 8.0
    static var iconImageViewSize = CGSize(width: 50, height: 50)
}
