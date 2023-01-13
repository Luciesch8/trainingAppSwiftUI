//
//  MapsViewModel.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 12/01/2023.
//
import MapKit
import SwiftUI
import Foundation


enum MapDetails{
    static let startingLoaction = CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054)
    static let defaulSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLoaction, span: MapDetails.defaulSpan)
    
    var locationManager : CLLocationManager?
    
    func checkIfLocationServiceIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }else{
            print("Show an alert letting them know this is off and to go turn it on")
        }
    }
    
    func checkLocationAuthorization(){
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Yours location is restricted likely due to parental controls")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaulSpan)
        @unknown default:
            break
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
