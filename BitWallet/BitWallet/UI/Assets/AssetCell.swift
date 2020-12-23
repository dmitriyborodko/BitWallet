import UIKit

class AssetCell: UITableViewCell, Reusable {

    var name: String? {
        get { nameLabel.text }
        set { nameLabel.text = newValue }
    }

    var price: String? {
        get { priceLabel.text }
        set { priceLabel.text = newValue }
    }

    var imageTarget: ImageTarget { ImageTarget(imageView: iconImageView, size: Constants.iconImageViewSize) }

    private lazy var overlayView: UIView = .init()
    private lazy var iconImageView: UIImageView = .init()
    private lazy var nameLabel: UILabel = .init()
    private lazy var priceLabel: UILabel = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        configureOverlayView()
        configureIconImageView()
        configureNameLabel()
        configurePriceLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        name = nil
        price = nil
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
            make.left.equalTo(iconImageView.snp.right).offset(Constants.nameLabelLeftOffset)
            make.centerY.equalTo(iconImageView.snp.centerY).offset(-Constants.iconImageViewSize.height / 4)
        }
    }

    private func configurePriceLabel() {
        overlayView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(Constants.nameLabelLeftOffset)
            make.centerY.equalTo(iconImageView.snp.centerY).offset(Constants.iconImageViewSize.height / 4)
        }
    }
}

private enum Constants {

    static let overlayViewCornerRadius: CGFloat = 16.0
    static let overlayViewEdgeInsets: UIEdgeInsets = .init(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)

    static let iconImageViewLeftTopBottomInset: CGFloat = 8.0
    static let iconImageViewSize = CGSize(width: 36.0, height: 36.0)

    static let nameLabelLeftOffset: CGFloat = 8.0
    static let nameToPriceLabelsSpacing: CGFloat = 4.0
}
