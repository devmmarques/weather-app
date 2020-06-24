
import UIKit

protocol WeatherMapOutPutViewProtocol: class {
    // Presenter -> View
    func showMap(weathers: [WeatherMap])
}

protocol WeatherMapInputPresenterProtocol: class {
    var interactor: WeatherMapInputInteractorProtocol? { get set }
    var view: WeatherMapOutPutViewProtocol? { get set }
    var wireframe: WWeatherMapWireframeProtocol? { get set }
    
    func fetch()
}

protocol WeatherMapInputInteractorProtocol: class {
    // Presenter -> Interactor
    var presenter: WeatherMapOutPutInteractorProtocol? { get set }
    func fetchWeathers()
}

protocol WeatherMapOutPutInteractorProtocol: class {
    // Interactor -> Presenter
    func showMap(weathers: [WeatherMap])
  
}

protocol WWeatherMapWireframeProtocol: class {
    // Presenter -> Wireframe
    func setupModularView(weathers: [Weather]) -> WeatherMapViewController
}
