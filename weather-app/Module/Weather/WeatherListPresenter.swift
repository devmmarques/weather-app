import UIKit

final class WeatherListPresenter: WeatherListPresenterProtocol {

    var wireframe: WeatherListWireframeProtocol?
    weak var view: WeatherListViewProtocol?
    var interactor: WeatherListInputInteractorProtocol?
    
    func viewDidLoad() {
        self.interactor?.fetchWeather()
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return self.interactor?.countListWeather() ?? 0
    }
    
    func getWeather(with index: Int) -> ListCellType<Weather>? {
        return self.interactor?.getWeather(with: index)
    }
    
    func getUnitTemperature() -> UnitTemperature {
        return self.interactor?.typeUnitTemperature ?? UnitTemperature.celsius
    }
    
    func changeUnitTemperature() {
        self.interactor?.changeUnitTemperature()
    }
    func showMapWeather(navigation: UINavigationController) {
        self.wireframe?.showMapWeather(typeUnitTemperature: self.interactor?.typeUnitTemperature ?? .celsius, navigation: navigation, weathers: self.interactor?.getWeather() ?? [])
    }
}

extension WeatherListPresenter: WeatherListOutPutInteractorProtocol {
    func showWeather() {
        self.view?.reloadData()
    }
    
    func showUnitTemperature() {
        self.view?.showUnitTemperature()
    }
    
}
