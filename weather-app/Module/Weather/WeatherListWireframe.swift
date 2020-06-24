import UIKit

class WeatherListWireframe: NSObject, WeatherListWireframeProtocol {
    
    weak var view: WeatherListViewController!
   
    func setupModularView(_ typeUnitTemperature: UnitTemperature = .celsius) -> WeatherListViewController {
           
        let view = WeatherListViewController()
        let interactor = WeatherListInteractor()
        interactor.typeUnitTemperature = typeUnitTemperature
        let presenter = WeatherListPresenter()
        
        presenter.wireframe = self
        presenter.view = view
        presenter.interactor = interactor

        view.presenter = presenter
        interactor.presenter = presenter

        self.view = view
        return view
    }
    
    func showMapWeather(typeUnitTemperature: UnitTemperature, navigation: UINavigationController, weathers: [Weather]) {
        let mapWireframe = WeatherMapWireframe().setupModularView(typeUnitTemperature, weathers: weathers)
        navigation.viewControllers = [mapWireframe]
    }
    
}
