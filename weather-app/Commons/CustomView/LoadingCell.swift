import UIKit
import Lottie

final class LoadingCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.accessibilityIdentifier = "backGroundView"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingView: AnimationView = {
        let animationView = AnimationView(name: "loading")
        let screen = UIScreen.main
        animationView.frame = screen.bounds
        animationView.accessibilityIdentifier = "loadingView"
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.backgroundColor = .clear
        setupViews()
        loadingView.play()
    }
}

extension LoadingCell: CodeViewProtocol {
    
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(loadingView)
    }
    
    func setupConstraints() {
        
        let screen = UIScreen.main.bounds
        self.containerView
            .topAnchor(equalTo: self.topAnchor)
            .leadingAnchor(equalTo: self.leadingAnchor)
            .trailingAnchor(equalTo: self.trailingAnchor)
            .bottomAnchor(equalTo: self.bottomAnchor)
        
        self.loadingView
            .topAnchor(equalTo: self.containerView.topAnchor, constant: 100.0)
            .leadingAnchor(equalTo: self.containerView.leadingAnchor)
            .trailingAnchor(equalTo: self.containerView.trailingAnchor)
            
        self.loadingView.heightAnchor(equalTo: screen.height / 3)
        
    }
}
