import UIKit

final class ErrorViewCell: UITableViewCell {
    
    private lazy var imageEmptyState: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.accessibilityIdentifier = "imageEmptyState"
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var stackViewVertical: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 10.0
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "labelTitleError"
        label.textAlignment = .center
        label.textColor = ColorName.grayStrong.color
        label.font = FontFamily.SFUIText.bold.font(size: 18.0)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "labelDescriptionError"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = ColorName.grayLight.color
        label.font = FontFamily.SFUIText.regular.font(size: 12.0)
        label.alpha = 0.7
        return label
    }()
    
    private lazy var buttonTryAgain: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "buttonErrorTryAgain"
        button.backgroundColor = ColorName.primaryBlue.color
        button.setTitle(L10n.buttonTryAgain.uppercased(), for: .normal)
        return button
    }()
    
    private var buttonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setupView(error: WebserviceError, completion: @escaping () -> Void) {
        self.buttonAction = completion
        
        switch error {
        case .notConnectedToInternet:
            imageEmptyState.image = Asset.icWireless.image
            titleLabel.text = L10n.errorInternetTitle
            descriptionLabel.text = L10n.errorInternetDescription
            accessibilityIdentifier = "notConnectedToInternetErrorView"
        case let .empty(emptyState):
            imageEmptyState.image = Asset.icEmptyStateWeather.image
            titleLabel.text = emptyState.title
            descriptionLabel.text = emptyState.description
            accessibilityIdentifier = "emptyState"
            buttonTryAgain.isHidden = true
        default:
            titleLabel.text = L10n.errorUnexpectedTitle
            descriptionLabel.text = L10n.errorUnexpectedDescription
            imageEmptyState.image = Asset.icErrorUnexpected.image
            accessibilityIdentifier = "unexpectedErrorView"
        }
        
        self.buttonTryAgain.layer.cornerRadius = 20
        buttonTryAgain.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    @objc private func actionButton() {
        buttonAction?()
        self.removeFromSuperview()
    }
}

extension ErrorViewCell: CodeViewProtocol {
    
    func buildViewHierarchy() {
        self.addSubview(self.imageEmptyState)
        self.addSubview(self.stackViewVertical)
        self.stackViewVertical.addArrangedSubview(titleLabel)
        self.stackViewVertical.addArrangedSubview(descriptionLabel)
        self.stackViewVertical.addArrangedSubview(buttonTryAgain)
    }
    
    func setupConstraints() {
        
        self.imageEmptyState
            .topAnchor(equalTo: self.topAnchor, constant: 40.0)
            .leadingAnchor(equalTo: self.leadingAnchor)
            .trailingAnchor(equalTo: self.trailingAnchor)
        self.imageEmptyState.heightAnchor(equalTo: 150.0)
        
        self.stackViewVertical
            .topAnchor(equalTo: self.imageEmptyState.bottomAnchor, constant: 40.0)
            .leadingAnchor(equalTo: self.leadingAnchor, constant: 20.0)
            .trailingAnchor(equalTo: self.trailingAnchor, constant: -20.0)
            .bottomAnchor(equalTo: self.bottomAnchor)
        
        let screen = UIScreen.main.bounds
        self.buttonTryAgain.widthAnchor(equalTo: screen.width - 50).heightAnchor(equalTo: 50.0)
    }
}
