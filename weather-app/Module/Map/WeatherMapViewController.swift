import UIKit
import MapKit


final class WeatherMapViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    var presenter: WeatherMapInputPresenterProtocol?
    private var locationManager = CLLocationManager()
    private var oldPopViewTag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupUI()
        self.setupLocationManager()
        self.presenter?.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(with: .default)
        
        self.changeIconNavigationButtonRight()
    }
    
    private func setupUI() {
        self.title = L10n.titleNavigationWeather
        self.mapView.delegate = self
        self.mapView.register(PopViewAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    private func setupUnitTemperature() {
        self.presenter?.changeUnitTemperature()
        self.presenter?.fetch()
    }
    
    private func showListWeather() {
        guard let navigation = self.navigationController else { return }
        self.presenter?.showListWeater(navigation: navigation)
    }
    
    private func changeIconNavigationButtonRight () {
        if let unitTemp = self.presenter?.getUnitTemperature() {
            setupNavigationButtonRightWeather(iconImage: Asset.iconList.image, iconType: unitTemp, actionButtonTemperature: {
                self.setupUnitTemperature()
            }) {
                self.showListWeather()
            }
        }
    }
    
    private func setupLocationManager() {
        guard let currentLat = LocationManager.shared.currentLat,
            let currentLong = LocationManager.shared.currentLong else { return }
        let initialLocation = CLLocation(latitude: currentLat, longitude: currentLong)
        self.setupZoomMap(initialLocation: initialLocation)
    }
    
    private func setupZoomMap(initialLocation: CLLocation) {
        let region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 50000, longitudinalMeters: 60000)
        self.mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 600000)
        self.mapView.setCameraZoomRange(zoomRange, animated: true)
        
    }
}

extension WeatherMapViewController: MKMapViewDelegate {
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? WeatherMap else {
          return nil
        }

        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = false
            view.showsLargeContentViewer = false
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let annotation = view.annotation as? WeatherMap else {
                 return
        }
        view.setSelected(false, animated: false)
        
        let popViewAnnotation = PopViewAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        popViewAnnotation.translatesAutoresizingMaskIntoConstraints = false
        popViewAnnotation.tag = Int.random(in: 20..<30)
        self.oldPopViewTag = popViewAnnotation.tag
        view.addSubview(popViewAnnotation)

        popViewAnnotation
            .bottomAnchor(equalTo: view.topAnchor, constant: -10.0)
            .centerXAnchor(equalTo: view.centerXAnchor, constant: view.calloutOffset.x)
            .widthAnchor(equalTo: 120.0)
            .heightAnchor(equalTo: 50.0)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        if let viewWithTag = view.viewWithTag(self.oldPopViewTag) {
            viewWithTag.removeFromSuperview()
            view.layoutIfNeeded()
        }
    }
    
}

extension WeatherMapViewController: WeatherMapOutPutViewProtocol {
    func showMap(weathers: [WeatherMap]) {
        if mapView.annotations.count > 0 {
            let currentAnnotations = mapView.annotations
            self.mapView.removeAnnotations(currentAnnotations)
        }
        DispatchQueue.main.async {
           self.mapView.addAnnotations(weathers)
        }
    }
    
    func showUnitTemperature() {
        self.changeIconNavigationButtonRight()
        self.mapView.reloadInputViews()
    }
}

extension WeatherMapViewController: CodeViewProtocol {
    
    func buildViewHierarchy() {
        self.view.addSubview(self.mapView)
    }
    
    func setupConstraints() {
        self.mapView
            .topAnchor(equalTo: self.view.topAnchor)
            .leadingAnchor(equalTo: self.view.leadingAnchor)
            .trailingAnchor(equalTo: self.view.trailingAnchor)
            .bottomAnchor(equalTo: self.view.bottomAnchor)
    }
}
