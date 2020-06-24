
import UIKit

public enum NavigationBarStyle {
    case `default`
    case colored(barColor: UIColor)
}

extension UIViewController {
    
    public func setupNavigationBar(with style: NavigationBarStyle,
                                   prefersLargeTitles: Bool = false) {
        
        guard let navigationController = navigationController else {
            return
        }
        
        switch style {
        case .default:
            navigationController.navigationBar.barTintColor = ColorName.primaryBlue.color
        case .colored(let barColor):
            navigationController.navigationBar.barTintColor = barColor
        }
        
        navigationController.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationController.navigationItem.hidesSearchBarWhenScrolling = false
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.layoutIfNeeded()
        navigationItem.backBarButtonItem?.title = ""
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setupNavigationButtonRightWeather(iconType: UnitTemperature = .celsius,
                                           actionButtonTemperature: @escaping () -> (),
                                           actionButtonMap: @escaping () -> ()) {
        var symbol = ""
        
        switch iconType {
        case .celsius:
            symbol = UnitTemperature.fahrenheit.symbol
        case .fahrenheit:
            symbol = UnitTemperature.celsius.symbol
        default:
            symbol = iconType.symbol
        }
        let buttonTemp = UIBarButtonItem(title: symbol, style: .done) { _ in
            actionButtonTemperature()
        }
        buttonTemp.tintColor = .white
       
        let buttonMap = UIBarButtonItem(image: Asset.icMaps.image, style: .done) { _ in
            actionButtonMap()
        }
        buttonMap.tintColor = .white
       
        navigationItem.rightBarButtonItems = [buttonMap, buttonTemp]
    }
    
    
}
