import UIKit

protocol WeatherListViewProtocol: class {
    //presenter -> View
}

protocol WeatherListPresenterProtocol: class {
    // View -> Presenter
}

protocol WeatherListInputInteractorProtocol: class {
    // Presenter -> Interactor
    func fetchWeather()
}

protocol WeatherListOutPutInteractorProtocol: class {
    // Interactor -> Presenter
}

protocol WeatherListWireframeProtocol: class {
    // Presenter -> Wireframe
}

protocol ContactsViewProtocol: class {
    // Presenter -> View
    func reloadContacts()
}

