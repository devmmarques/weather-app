import UIKit

final class WeatherMapWireframe: NSObject {
    
    
    // MARK: - Viper Properties
    
    weak var view: WeatherMapViewController!
    weak var presenter: WeatherMapPresenter!
    
//
//    init(weathers: [Weather]) {
//        super.init()
//
//        let view = WeatherMapViewController()
//        let interactor = WeatherMapInteractor(weathers: weathers)
//        let presenter = WeatherMapPresenter()
//
//        presenter.interactor = interactor
//        presenter.wireframe = self
//        presenter.view = view
//
//        view.presenter = presenter
//        interactor.presenter = presenter
//
//        self.view = view
//        self.presenter = presenter
//    }
}

extension WeatherMapWireframe: WWeatherMapWireframeProtocol {
    
    func setupModularView(weathers: [Weather]) -> WeatherMapViewController {
        let view = WeatherMapViewController()
        let interactor = WeatherMapInteractor(weathers: weathers)
        let presenter = WeatherMapPresenter()
                      
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = view
                      
        view.presenter = presenter
        interactor.presenter = presenter
        
        self.view = view
        return view
    }
    
}
