import UIKit

class WeatherListInteractor: WeatherListInputInteractorProtocol {

    weak var presenter: WeatherListOutPutInteractorProtocol?
    let service: WeatherServiceProtocol
    
    var listWeather: [ListCellType<Weather>] = [] {
        didSet {
            self.presenter?.showWeather()
        }
    }
    
    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func fetchWeather() {
        self.listWeather = [.loading];
        self.service.fetchWeather { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(weatherResponse):
                print(weatherResponse)
                self.presenter?.showWeather()
            case let .failure(error):
                self.listWeather = [.error(error)]
            }
        }
    }
    
    func countListWeather() -> Int {
        return self.listWeather.count
    }
    
    func getWeather(with index: Int) -> ListCellType<Weather> {
        return self.listWeather[index]
    }
}
