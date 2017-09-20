//
//  MapViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 19/06/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit
import GoogleMaps


class MapViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, GMSMapViewDelegate {

    @IBOutlet var MapView: GMSMapView!
    let annotation = GMSMarker()
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTheLocationManager()
        self.MapView.isMyLocationEnabled = true
        MapView.delegate = self
        
        let button = UIBarButtonItem(title: "SET", style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = button
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initializeTheLocationManager()
    {
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager,      didUpdateLocations locations: [CLLocation]) {
        
        let location = locationManager.location?.coordinate
        
        cameraMoveToLocation(toLocation: location)
        
    }
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if toLocation != nil {
            MapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 3.0)
            
            
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        
        annotation.position = coordinate
        annotation.map = MapView
        
        var lat = String(coordinate.latitude)
        var lon = String(coordinate.longitude)
        UserDefaults.standard.set(lat, forKey: "lat")
        UserDefaults.standard.set(lon, forKey: "lon")
        
    }
    
    
    func addTapped(){
        
        let set = self.storyboard?.instantiateViewController(withIdentifier: "Fourth") as! FourthViewController
        self.navigationController?.popViewController(animated: true)
        
        
         
        
        
    }
 
    
    
    
    
}




    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    */

    


