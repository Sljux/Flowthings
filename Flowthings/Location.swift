//
//  Location.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/28/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import CoreLocation

//"location": {
//    "lat": 40.703285,
//    "lon": -73.987852,
//    "specifiers": {
//        "city": "New York City",
//        "zip": "11201",
//        "street": "155 Water Street",
//        "state": "NY"
//    }
//},

struct LocationSpecifiers {
    var city : String?
    var zip : String?
    var street : String?
    var state : String?
    
}

struct Location {
    
    var lat : Double?
    var lon : Double?
    var specifiers : LocationSpecifiers
    var manager: CurrentLocationManager?
    
    var dict : [String:Double] {
        
        if let lat = self.lat,
            let lon = self.lon {
                return ["lat" : lat, "lon" : lon]
        } else {
            return [:]
        }
    }
    
    init(){
        specifiers = LocationSpecifiers()
    }
    
    init(latitude: Double, longitude: Double){
        specifiers = LocationSpecifiers()
        self.lat = latitude
        self.lon = longitude
    }
    
    
    
    mutating func setCurent() {
        
        manager = CurrentLocationManager()
        manager!.fetchWithCompletion {
            location, error in
            
            if let loc = location {
                self.lat = loc.coordinate.latitude
                self.lon = loc.coordinate.longitude
            } else if let err = error {
                print(err.localizedDescription)
            }
            self.manager = nil
        }
    }
    
    
}

//possible errors
enum CurrentLocationManagerErrors: Int {
    case AuthorizationDenied
    case AuthorizationNotDetermined
    case InvalidLocation
}

class CurrentLocationManager: NSObject, CLLocationManagerDelegate {
    
    //location manager
    private var locationManager: CLLocationManager?
    
    //destroy the manager
    deinit {
        locationManager?.delegate = nil
        locationManager = nil
    }
    
    typealias LocationClosure = ((location: CLLocation?, error: NSError?)->())
    private var didComplete: LocationClosure?
    
    //location manager returned, call didcomplete closure
    private func _didComplete(location: CLLocation?, error: NSError?) {
        locationManager?.stopUpdatingLocation()
        didComplete?(location: location, error: error)
        locationManager?.delegate = nil
        locationManager = nil
    }
    
    //location authorization status changed
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .AuthorizedWhenInUse:
            self.locationManager!.startUpdatingLocation()
        case .Denied:
            _didComplete(nil, error: NSError(domain: self.classForCoder.description(),
                code: CurrentLocationManagerErrors.AuthorizationDenied.rawValue,
                userInfo: nil))
        default:
            break
        }
    }
    
    internal func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        _didComplete(nil, error: error)
    }
    
    
    internal func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            _didComplete(locations[0], error: nil)
        } else {
            _didComplete(nil, error: NSError(domain: self.classForCoder.description(),
                code: CurrentLocationManagerErrors.InvalidLocation.rawValue,
                userInfo: nil))
        }
    }
    
    //ask for location permissions, fetch 1 location, and return
    func fetchWithCompletion(completion: LocationClosure) {
        //store the completion closure
        didComplete = completion
        
        //fire the location manager
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        
        //check for description key and ask permissions
        if (NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationWhenInUseUsageDescription") != nil) {
            locationManager!.requestWhenInUseAuthorization()
        } else if (NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil) {
            locationManager!.requestAlwaysAuthorization()
        } else {
            fatalError("To use location in iOS8 you need to define either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription in the app bundle's Info.plist file")
        }
        
    }
}