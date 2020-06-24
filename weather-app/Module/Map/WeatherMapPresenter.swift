import UIKit

final class WeatherMapPresenter: WeatherMapInputPresenterProtocol {
    
    var interactor: WeatherMapInputInteractorProtocol?
    var view: WeatherMapOutPutViewProtocol?
    var wireframe: WWeatherMapWireframeProtocol?
    
    func fetch() {
        self.interactor?.fetchWeathers()
    }
}

extension WeatherMapPresenter: WeatherMapOutPutInteractorProtocol {
    
    func showMap(weathers: [WeatherMap]) {
        self.view?.showMap(weathers: weathers)
    }
}
