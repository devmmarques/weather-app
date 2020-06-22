import UIKit

final class WeatherViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
       let image = UIImageView(frame: .zero)
       image.translatesAutoresizingMaskIntoConstraints = false
       image.contentMode = .scaleAspectFit
       image.accessibilityIdentifier = "iconImage"
       return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var typeWeatherLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    
    private lazy var minMaxWeatherLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    
    private lazy var tempWeatherLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 26.0)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupUI()
    }
      
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.containerView.applyShadow(color: .lightGray, opacity: 5, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
    }
    
    func setupWeather(weather: Weather, outputTempType: UnitTemperature) {
        self.cityLabel.text = weather.name
        self.typeWeatherLabel.text = weather.weather.first?.description ?? L10n.emptyStateLabel
        self.minMaxWeatherLable.text = "Min \(weather.main.tempMin.convertTemp(from: .kelvin, to: outputTempType))  Max \(weather.main.tempMax.convertTemp(from: .kelvin, to: outputTempType))"
        
        self.tempWeatherLabel.text = weather.main.temp.convertTemp(from: .kelvin, to: .celsius)
        
        if let iconName = weather.weather.first?.icon {
            self.iconImage.imageFromURL(urlString: Environment.current.baseURLImageString + "\(iconName)" + Environment.current.baseExtensionIcon)
        }
    }
}

extension WeatherViewCell: CodeViewProtocol {
    
    func buildViewHierarchy() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.cityLabel)
        self.containerView.addSubview(self.stackView)
        self.containerView.addSubview(self.iconImage)
        self.stackView.addArrangedSubview(self.typeWeatherLabel)
        self.stackView.addArrangedSubview(self.tempWeatherLabel)
        self.containerView.addSubview(self.minMaxWeatherLable)
    }
    
    func setupConstraints() {
        
        self.containerView
            .topAnchor(equalTo: self.topAnchor, constant: 12.0)
            .leadingAnchor(equalTo: self.leadingAnchor, constant: 12.0)
            .trailingAnchor(equalTo: self.trailingAnchor, constant: -12.0)
            .bottomAnchor(equalTo: self.bottomAnchor, constant: -12.0)
        
        self.cityLabel
            .topAnchor(equalTo: self.containerView.topAnchor, constant: 12.0)
            .leadingAnchor(equalTo: self.containerView.leadingAnchor, constant: 14.0)
            .trailingAnchor(equalTo: self.containerView.trailingAnchor, constant: -10.0)
        
        self.iconImage
            .topAnchor(equalTo: self.cityLabel.bottomAnchor, constant: 12.0)
            .leadingAnchor(equalTo: self.containerView.leadingAnchor, constant: 10.0)
        
        self.iconImage
            .heightAnchor(equalTo: 40.0)
            .widthAnchor(equalTo: 40.0)
        
        self.stackView
            .topAnchor(equalTo: self.cityLabel.bottomAnchor)
            .leadingAnchor(equalTo: self.iconImage.trailingAnchor, constant: 10.0)
            .trailingAnchor(equalTo: self.containerView.trailingAnchor, constant: -10.0)
            .centerYAnchor(equalTo: self.iconImage.centerYAnchor)
        
        self.minMaxWeatherLable
            .topAnchor(equalTo: self.iconImage.bottomAnchor, constant: 12.0)
            .leadingAnchor(equalTo: self.containerView.leadingAnchor, constant: 14.0)
            .trailingAnchor(equalTo: self.containerView.trailingAnchor, constant: -10.0)
            .bottomAnchor(equalTo: self.containerView.bottomAnchor, constant: -12.0)
    }
}
