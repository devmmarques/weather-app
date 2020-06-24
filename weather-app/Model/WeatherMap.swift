import MapKit

class WeatherMap: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let temp: Double
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, locationName: String?, temp: Double, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.temp = temp
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
