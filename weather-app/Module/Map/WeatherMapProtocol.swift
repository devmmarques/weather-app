
import UIKit

protocol WeatherMapOutPutViewProtocol: class {
    // Presenter -> View
    func showMap(weathers: [WeatherMap])
    func showUnitTemperature()
}

protocol WeatherMapInputPresenterProtocol: class {
    var interactor: WeatherMapInputInteractorProtocol? { get set }
    var view: WeatherMapOutPutViewProtocol? { get set }
    var wireframe: WWeatherMapWireframeProtocol? { get set }
    
    func fetch()
    func changeUnitTemperature()
    func getUnitTemperature() -> UnitTemperature
    func showListWeater(navigation: UINavigationController)
}

protocol WeatherMapInputInteractorProtocol: class {
    // Presenter -> Interactor
    var presenter: WeatherMapOutPutInteractorProtocol? { get set }
    var typeUnitTemperature: UnitTemperature { get set }
    func fetchWeathers()
    func changeUnitTemperature()
}

protocol WeatherMapOutPutInteractorProtocol: class {
    // Interactor -> Presenter
    func showMap(weathers: [WeatherMap])
    func showUnitTemperature()
}

protocol WWeatherMapWireframeProtocol: class {
    // Presenter -> Wireframe
    func setupModularView(_ typeUnitTemperature: UnitTemperature, weathers: [Weather]) -> WeatherMapViewController
    func showListWeater(navigation: UINavigationController, typeUnitTemperature: UnitTemperature)
}
