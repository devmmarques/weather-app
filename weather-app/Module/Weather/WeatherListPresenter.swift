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
}

extension WeatherListPresenter: WeatherListOutPutInteractorProtocol {
    func showWeather() {
        self.view?.reloadData()
    }
}
