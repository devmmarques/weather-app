import UIKit
import MapKit

class PopViewAnnotationView: MKPinAnnotationView {
    
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleTemperature: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    
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
}

extension PopViewAnnotationView: CodeViewProtocol {
    
    func buildViewHierarchy() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.titleTemperature)
    }
    
    func setupConstraints() {
        self.containerView
            .topAnchor(equalTo: self.topAnchor)
            .leadingAnchor(equalTo: self.leadingAnchor)
            .trailingAnchor(equalTo: self.trailingAnchor)
            .bottomAnchor(equalTo: self.bottomAnchor)
        
        self.titleTemperature
            .topAnchor(equalTo: self.containerView.topAnchor)
            .leadingAnchor(equalTo: self.containerView.leadingAnchor)
            .trailingAnchor(equalTo: self.containerView.trailingAnchor)
            .bottomAnchor(equalTo: self.containerView.bottomAnchor)
    }
}

private extension PopViewAnnotationView {
    func configure() {
        canShowCallout = true
        configureDetailView()
    }

    func configureDetailView() {
        guard let annotation = annotation else { return }
        self.titleTemperature.text = annotation.title ?? "TESTE"

    }
}
