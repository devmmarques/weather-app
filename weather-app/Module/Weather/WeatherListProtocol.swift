import UIKit

protocol WeatherListViewProtocol: class {
    func reloadData()
    func showUnitTemperature()
}

protocol WeatherListPresenterProtocol: class {
    var interactor: WeatherListInputInteractorProtocol? { get set }
    var view: WeatherListViewProtocol? { get set }
    var wireframe: WeatherListWireframeProtocol? { get set }
    
    func viewDidLoad()
    func numberOfSection() -> Int
    func numberOfRowsInSection() -> Int
    func getWeather(with index: Int) -> ListCellType<Weather>?
    func getUnitTemperature() -> UnitTemperature
    func changeUnitTemperature()
    func showMapWeather()
}

protocol WeatherListInputInteractorProtocol: class {
    // Presenter -> Interactor
    var presenter: WeatherListOutPutInteractorProtocol? {get set}
    var typeUnitTemperature: UnitTemperature { get set }
    func fetchWeather()
    func countListWeather() -> Int
    func getWeather() -> [Weather]
    func getWeather(with index: Int) -> ListCellType<Weather>
    func changeUnitTemperature()
}

protocol WeatherListOutPutInteractorProtocol: class {
    // Interactor -> Presenter
    func showWeather()
    func showUnitTemperature()
}

protocol WeatherListWireframeProtocol: class {
    // Presenter -> Wireframe
    func setupModularView() -> WeatherListViewController
    func showMapWeather(weathers: [Weather])
}
