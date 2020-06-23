import UIKit

final class WeatherListWireframe: WeatherListWireframeProtocol {
    
    
    class func createWeatherListModule(controller: WeatherListViewController) {
       let presenter: WeatherListPresenterProtocol & WeatherListOutPutInteractorProtocol = WeatherListPresenter()
        
        controller.presenter = presenter
        controller.presenter?.wireframe = WeatherListWireframe()
        controller.presenter?.view = controller
        controller.presenter?.interactor = WeatherListInteractor()
        controller.presenter?.interactor?.presenter = presenter
    }
    
}
