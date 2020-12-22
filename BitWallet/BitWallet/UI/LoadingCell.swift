import UIKit
import SnapKit

class LoadingCell: UITableViewCell, Reusable {

    private lazy var activityIndicator: UIActivityIndicatorView = .init(style: .large)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        activityIndicator.startAnimating()
    }

    private func configureUI() {
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16.0)
            make.centerX.equalToSuperview()
        }

        activityIndicator.startAnimating()
    }
}
