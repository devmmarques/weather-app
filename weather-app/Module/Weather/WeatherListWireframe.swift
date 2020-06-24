import UIKit

class WeatherListWireframe: NSObject, WeatherListWireframeProtocol {
    
    weak var view: WeatherListViewController!
   
    func setupModularView() -> WeatherListViewController {
           
        let view = WeatherListViewController()
        let interactor = WeatherListInteractor()
        let presenter = WeatherListPresenter()

        presenter.wireframe = self
        presenter.view = view
        presenter.interactor = interactor

        view.presenter = presenter
        interactor.presenter = presenter

        self.view = view
        return view
    }
    
    func showMapWeather(weathers: [Weather]) {
        let mapWireframe = WeatherMapWireframe().setupModularView(weathers: weathers)
        view.navigationController?.pushViewController(mapWireframe, animated: true)
    }
    
}
