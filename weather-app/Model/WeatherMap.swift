import MapKit

class WeatherMap: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let temp: Double
    let iconUrl: String
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, locationName: String?, temp: Double, iconUrl: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.temp = temp
        self.iconUrl = iconUrl
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
