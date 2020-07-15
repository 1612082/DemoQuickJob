//
//  MapViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/13/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: OTHER VARIABLES
    var lat:Double?
    var lon:Double?
    var addr:String?
    //MARK: VIEW LIFE CYCLE
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        setupVar()
        callAPI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - SETUP VAR
    func setupVar() {
        let initialLocation = CLLocation(latitude: lat ?? 0, longitude: lon ?? 0)
        mapView.centerToLocation(initialLocation)
        let oahuCenter = CLLocation(latitude: lat ?? 0, longitude: lon ?? 0)
        let region = MKCoordinateRegion(
          center: oahuCenter.coordinate,
          latitudinalMeters: 50000,
          longitudinalMeters: 60000)
        mapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        let artwork = Artwork(
          title: "Nơi làm việc",
          locationName: addr ?? "",
          discipline: "",
          coordinate: CLLocationCoordinate2D(latitude: lat ?? 0, longitude: lon ?? 0))
        mapView.addAnnotation(artwork)
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        
    }
    
    //MARK: - BUTTON ACTIONS
    
    
    
}
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return locationName
  }
}
