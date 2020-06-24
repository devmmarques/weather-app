import Foundation
import CoreLocation

class LocationManager {

    static let shared = LocationManager()
    var locationParameters: [String: Any]?
    var currentLat: CLLocationDegrees?
    var currentLong: CLLocationDegrees?

    func sendLocation(location: CLLocation) {
        self.locationParameters = self.locationParameters(location: location)
    }

    
    private func locationParameters(location: CLLocation) -> [String: Any] {
        
        let locationDictionary: [String: Any] = [
            "lat": location.coordinate.latitude,
            "lon": location.coordinate.longitude
        ]
        self.currentLat = location.coordinate.latitude
        self.currentLong = location.coordinate.longitude
        
        return locationDictionary
    }
}
