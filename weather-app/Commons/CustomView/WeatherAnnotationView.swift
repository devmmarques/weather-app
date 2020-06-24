import MapKit
import UIKit

final class WeatherAnnotationView: MKAnnotationView {
    
    private lazy var iconWeather: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var labelTemperature: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .lightGray
        label.backgroundColor = .clear
        return label
    }()
    
    private let annotationFrame = CGRect(x: 0, y: 0, width: 80, height: 40)
    
    public var temp: String = "" {
        didSet {
            self.labelTemperature.text = temp
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = annotationFrame
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented!")
    }
    
}

extension WeatherAnnotationView: CodeViewProtocol {
    
    func buildViewHierarchy() {
        self.addSubview(self.labelTemperature)
    }
    
    func setupConstraints() {
        self.labelTemperature
            .topAnchor(equalTo: self.topAnchor)
            .leadingAnchor(equalTo: self.leadingAnchor)
            .trailingAnchor(equalTo: self.trailingAnchor)
            .bottomAnchor(equalTo: self.bottomAnchor)
    }
}
