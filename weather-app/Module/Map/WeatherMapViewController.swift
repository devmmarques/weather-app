import UIKit
import MapKit


final class WeatherMapViewController: UIViewController {
    
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    var locationManager = CLLocationManager()
    var presenter: WeatherMapInputPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupLocationManager()
        self.mapView.delegate = self
        self.mapView.register(PopViewAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        self.presenter?.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(with: .default)
    }
    
    private func setupLocationManager() {
        guard let currentLat = LocationManager.shared.currentLat, let currentLong = LocationManager.shared.currentLong else { return }
        let initialLocation = CLLocation(latitude: currentLat, longitude: currentLong)
//        self.mapView.centerToLocation(initialLocation
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

        let identifier = "artwork"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let annotation = view.annotation as? WeatherMap else {
                 return
        }
        
        let popViewAnnotation = PopViewAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        popViewAnnotation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popViewAnnotation)
        
        popViewAnnotation
            .bottomAnchor(equalTo: view.topAnchor)
            .centerXAnchor(equalTo: view.centerXAnchor, constant: view.calloutOffset.x)
            .widthAnchor(equalTo: 120.0)
            .heightAnchor(equalTo: 40.0)

    }
    
}

extension WeatherMapViewController: WeatherMapOutPutViewProtocol {
    func showMap(weathers: [WeatherMap]) {
        self.mapView.addAnnotations(weathers)
    }
}

extension WeatherMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
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
