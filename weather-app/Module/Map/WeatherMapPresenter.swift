import UIKit

final class WeatherMapPresenter: WeatherMapInputPresenterProtocol {
    
    var interactor: WeatherMapInputInteractorProtocol?
    var view: WeatherMapOutPutViewProtocol?
    var wireframe: WWeatherMapWireframeProtocol?
    
    func fetch() {
        self.interactor?.fetchWeathers()
    }
    
    func changeUnitTemperature() {
        self.interactor?.changeUnitTemperature()
    }
    
    func getUnitTemperature() -> UnitTemperature {
        return self.interactor?.typeUnitTemperature ?? .celsius
    }
    
    func showListWeater(navigation: UINavigationController){
        self.wireframe?.showListWeater(navigation: navigation, typeUnitTemperature: self.interactor?.typeUnitTemperature ?? .celsius)
    }
}

extension WeatherMapPresenter: WeatherMapOutPutInteractorProtocol {
    
    func showMap(weathers: [WeatherMap]) {
        self.view?.showMap(weathers: weathers)
    }
    
    func showUnitTemperature() {
        self.view?.showUnitTemperature()
    }
}
