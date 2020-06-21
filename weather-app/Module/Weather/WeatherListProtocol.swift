import UIKit

protocol WeatherListViewProtocol: class {
    func reloadData()
}

protocol WeatherListPresenterProtocol: class {
    var interactor: WeatherListInputInteractorProtocol? { get set }
    var view: WeatherListViewProtocol? { get set }
    var wireframe: WeatherListWireframeProtocol? { get set }
    
    func viewDidLoad()
    func numberOfSection() -> Int
    func numberOfRowsInSection() -> Int
    func getWeather(with index: Int) -> ListCellType<Weather>?
}

protocol WeatherListInputInteractorProtocol: class {
    // Presenter -> Interactor
    var presenter: WeatherListOutPutInteractorProtocol? {get set}
    func fetchWeather()
    func countListWeather() -> Int
    func getWeather(with index: Int) -> ListCellType<Weather>
}

protocol WeatherListOutPutInteractorProtocol: class {
    // Interactor -> Presenter
    func showWeather()
}

protocol WeatherListWireframeProtocol: class {
    // Presenter -> Wireframe
}

protocol ContactsViewProtocol: class {
    // Presenter -> View
    func reloadContacts()
}

