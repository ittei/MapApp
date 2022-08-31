//
//  ViewController.swift
//  Map
//
//  Created by 小野里粋挺 on 2022/06/22.
//

import UIKit
import MapKit
import CoreLocation

class MapAnnotationSetting: MKPointAnnotation {
//    var pinImage: UIImage?
    var pinImage: UIImagePickerController?
}

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
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
            let pin = MapAnnotationSetting()
            
            //カメラロール
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                
                picker.allowsEditing = true
                
                present(picker, animated: true, completion: nil)
            }
            //
            
            // 用意したデータをセット
            let coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
            // 画像をセットできる
//            pin.pinImage = UIImage(named: "ra-men")
            pin.pinImage = UIImagePickerController()
            // ピンを立てる
            pin.coordinate = coordinate
            self.mapView.addAnnotation(pin)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
         // 自分の現在地は置き換えない(青いフワフワのマークのままにする)
         if (annotation is MKUserLocation) {
             return nil
         }

         let identifier = "pin"
         var annotationView: MKAnnotationView!

         if annotationView == nil {
             annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
         }

         // ピンにセットした画像をつける
//         if let pin = annotation as? MapAnnotationSetting {
//             if let pinImage = pin.pinImage {
//                annotationView.image = pinImage
//                annotationView.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
//             }
//         }
//         annotationView.annotation = annotation
//         // ピンをタップした時の吹き出しの表示
//         annotationView.canShowCallout = true

         return annotationView
     }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView.image = info[.editedImage] as? UIImage
        
    }
    
}
