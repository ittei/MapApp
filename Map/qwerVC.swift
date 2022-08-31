//
//  qwerVC.swift
//  Map
//
//  Created by 小野里粋挺 on 2022/07/27.
//

import UIKit
import MapKit
import CoreLocation

//class MapAnnotationSetting: MKPointAnnotation {
//    // デフォルトだとピンにはタイトル・サブタイトルしかないので、設定を追加する
//    // 今回は画像だけカスタムにしたいので画像だけ追加
//    var pinImage: UIImage?
//}

class qwerVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
        var locationManager: CLLocationManager!

        // とりあえずテストデータで画像・タイトル・サブタイトル・位置情報を用意
        let pinImagges: [UIImage?] = [UIImage(named: "ring")]
        let pinTitles: [String] = ["まる"]
        let pinSubTiiles: [String] = ["あ"]
        let pinlocations: [CLLocationCoordinate2D] = [CLLocationCoordinate2DMake(35.68, 139.56)]

        override func viewDidLoad() {
            super.viewDidLoad()

            // 省略

            // カスタムピンの表示
            // for文で配列の値を回す(ここはいろんなやり方があると思います。)
            for (index,pinTitle) in self.pinTitles.enumerated() {
                // カスタムで作成したMapAnnotationSettingをセット(これで画像をセットできる)
                let pin = MapAnnotationSetting()

                // 用意したデータをセット
                let coordinate = self.pinlocations[index]
                pin.title = pinTitle
                pin.subtitle = self.pinSubTiiles[index]
                // 画像をセットできる
                pin.pinImage = pinImagges[index]

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
            if let pin = annotation as? MapAnnotationSetting {
                if let pinImage = pin.pinImage {
                   annotationView.image = pinImage
                    annotationView.bounds = CGRect(x: 0, y: 0, width: 55, height: 64)
                }
            }
            annotationView.annotation = annotation
            // ピンをタップした時の吹き出しの表示
            annotationView.canShowCallout = true

            return annotationView
        }
    
}
