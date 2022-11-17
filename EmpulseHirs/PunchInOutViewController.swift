//
//  PunchInOutViewController.swift
//  EmpulseHirs
//
//  Created by apple on 22/08/22.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps

class PunchInOutViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var btnPunchOut: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnPunchIn: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0
    let locationManager = CLLocationManager()
    var objPunchViewModel = PunchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = UserDefaults.standard.string(forKey: "name") ?? "Uttam Kumar Barai"
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        //  imgProfile.image = UIImage(url: URL(string: "https://picsum.photos/200"))
        
        if lat == "" || long == ""{
            self.btnPunchIn.backgroundColor = .lightGray
            self.btnPunchIn.isEnabled = false
            self.btnPunchOut.backgroundColor = .lightGray
            self.btnPunchOut.isEnabled = false
        }else{
            self.btnPunchIn.backgroundColor = .black
            self.btnPunchIn.isEnabled = true
            self.btnPunchOut.backgroundColor = .black
            self.btnPunchOut.isEnabled = true
        }
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionPunchIn(_ sender: UIButton) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.string(from: date)
        debugPrint(dateFormatter.string(from: date))
        punchTime = dateFormatter.string(from: date)
        PunchType = "IN"
        objPunchViewModel.punchIn(vw: self.view) {
            self.btnPunchIn.backgroundColor = .lightGray
            self.btnPunchIn.isEnabled = false
            //self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func actionPunchOut(_ sender: UIButton) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.string(from: date)
        debugPrint(dateFormatter.string(from: date))
        punchTime = dateFormatter.string(from: date)
        PunchType = "OUT"
        objPunchViewModel.punchOut(vw: self.view) {
            self.btnPunchOut.backgroundColor = .lightGray
            self.btnPunchOut.isEnabled = false
            // self.navigationController?.popViewController(animated: true)
        }
    }
}
// Delegates to handle events for the location manager.
extension PunchInOutViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        self.lblLat.text = "\(location.coordinate.latitude) , \(location.coordinate.longitude)"
        lat = "\(location.coordinate.latitude)"
        long = "\(location.coordinate.longitude)"
        
        if lat == "" || long == ""{
            self.btnPunchIn.backgroundColor = .lightGray
            self.btnPunchIn.isEnabled = false
            self.btnPunchOut.backgroundColor = .lightGray
            self.btnPunchOut.isEnabled = false
        }else{
            self.btnPunchIn.backgroundColor = .black
            self.btnPunchIn.isEnabled = true
            self.btnPunchOut.backgroundColor = .black
            self.btnPunchOut.isEnabled = true
        }
        
        print("Location: \(location)")
        showMarker(lat: location.coordinate.latitude, long: location.coordinate.longitude)
        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    func showMarker(lat :Double = -33.86,long :Double = 151.20){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude:long , zoom: 6.0)
        mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.map = mapView
    }
}
extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            self.init(data: try Data(contentsOf: url))
            debugPrint(url)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}






