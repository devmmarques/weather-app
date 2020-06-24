import UIKit

final class WeatherMapWireframe: NSObject {
    
    
    // MARK: - Viper Properties
    
    weak var view: WeatherMapViewController!
    weak var presenter: WeatherMapPresenter!
 
}

extension WeatherMapWireframe: WWeatherMapWireframeProtocol {
    
    func setupModularView(_ typeUnitTemperature: UnitTemperature = .celsius, weathers: [Weather]) -> WeatherMapViewController {
        let view = WeatherMapViewController()
        let interactor = WeatherMapInteractor(weathers: weathers)
        interactor.typeUnitTemperature = typeUnitTemperature
        let presenter = WeatherMapPresenter()
                      
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = view
                      
        view.presenter = presenter
        interactor.presenter = presenter
        
        self.view = view
        return view
    }
    
    func showListWeater(navigation: UINavigationController, typeUnitTemperature: UnitTemperature) {
        let listWeatherWireframe = WeatherListWireframe().setupModularView(typeUnitTemperature)
        navigation.viewControllers = [listWeatherWireframe]
    }
}
