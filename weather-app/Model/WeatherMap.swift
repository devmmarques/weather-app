import MapKit

class WeatherMap: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let temp: Double
    let iconUrl: String
    let unitTemp: UnitTemperature
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, locationName: String?, temp: Double, iconUrl: String, unitTemp: UnitTemperature, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.temp = temp
        self.iconUrl = iconUrl
        self.coordinate = coordinate
        self.unitTemp = unitTemp
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
