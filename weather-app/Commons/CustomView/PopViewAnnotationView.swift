import UIKit
import MapKit

class PopViewAnnotationView: MKPinAnnotationView {
    
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var iconImage: UIImageView = {
       let image = UIImageView(frame: .zero)
       image.translatesAutoresizingMaskIntoConstraints = false
       image.contentMode = .scaleAspectFit
       image.accessibilityIdentifier = "iconImage"
       return image
    }()
    
    private lazy var titleTemperature: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var typeUnitTemperature: UnitTemperature?
    
    override var annotation: MKAnnotation? {
        didSet {
            configureDetailView()
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        self.containerView.addPikeOnView(side: .Bottom)
        self.containerView.applyShadow()
    }
}

extension PopViewAnnotationView: CodeViewProtocol {
    
    func buildViewHierarchy() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.iconImage)
        self.containerView.addSubview(self.titleTemperature)
    }
    
    func setupConstraints() {
        self.containerView
            .topAnchor(equalTo: self.topAnchor)
            .leadingAnchor(equalTo: self.leadingAnchor)
            .trailingAnchor(equalTo: self.trailingAnchor)
            .bottomAnchor(equalTo: self.bottomAnchor)
        
        self.iconImage
            .topAnchor(equalTo: self.containerView.topAnchor)
            .leadingAnchor(equalTo: self.containerView.leadingAnchor)
            .bottomAnchor(equalTo: self.containerView.bottomAnchor)
            .heightAnchor(equalTo: 50.0)
            .widthAnchor(equalTo: 50.0)
        
        self.titleTemperature
            .centerYAnchor(equalTo: self.iconImage.centerYAnchor)
            .leadingAnchor(equalTo: self.iconImage.trailingAnchor)
            .trailingAnchor(equalTo: self.containerView.trailingAnchor)
    }
}

private extension PopViewAnnotationView {
    func configure() {
        canShowCallout = true
        configureDetailView()
    }

    func configureDetailView() {
        guard let annotation = annotation as? WeatherMap else { return }
        self.titleTemperature.text = annotation.temp.convertTemp(from: .kelvin, to: self.typeUnitTemperature ?? .celsius)
        self.iconImage.imageFromURL(urlString: annotation.iconUrl)
    }
}
