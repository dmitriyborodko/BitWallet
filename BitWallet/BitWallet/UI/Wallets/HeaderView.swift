import UIKit

class HeaderView: UITableViewHeaderFooterView, Reusable {

    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    private lazy var titleLabel: UILabel = .init()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        configureTitleLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.titleLabelEdgeInsets)
        }
    }
}

private enum Constants {

    static var titleLabelEdgeInsets: UIEdgeInsets = .init(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
}
