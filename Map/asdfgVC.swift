//
//  asdfgVC.swift
//  Map
//
//  Created by 小野里粋挺 on 2022/07/27.
//

import UIKit
import MapKit
import CoreLocation

class asdfgViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        let coordinate = mapView.userLocation.coordinate
        let userLocation = MKPointAnnotation()
        userLocation.coordinate = coordinate
        mapView.addAnnotation(userLocation)
        mapView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager,didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
        default:
            break
        }
    }
    
    @IBAction func pressMap(_ sender: UILongPressGestureRecognizer) {
        let location:CGPoint = sender.location(in: mapView)
        if (sender.state == UIGestureRecognizer.State.ended) {
            let mapPoint:CLLocationCoordinate2D = mapView.convert(location,toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
            annotation.title = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
            
            mapView.addAnnotation(annotation)
        }
    }
}
