//
//  MapViewController.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 20..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private weak var mapContainerView: UIView!
    @IBOutlet private weak var pathNameLabel: UILabel!
    
    var paths: [Result?]?
    var trail: Trail?
    
    var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMapView()
        updateUI()
    }
    
    func addMapView() {
        mapView = createMapView(position: paths?.compactMap { $0 }.first)
        drawPath(position: paths)
        mapContainerView.addSubview(mapView ?? UIView())
    }
    
    func updateUI() {
        pathNameLabel.text = trail?.attributes?.pathName
    }
    
    func createMapView(position: Result?) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: position?.posY ?? 0, longitude: position?.posX ?? 0, zoom: 16)
        let mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.mapType = .normal
        return mapView
    }
    
    func drawPath(position: [Result?]?) {
        let path = GMSMutablePath()
        position?.forEach {
            let x = Double($0?.posX ?? 0)
            let y = Double($0?.posY ?? 0)
            path.addLatitude(y, longitude: x)
        }
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4
        polyline.strokeColor = #colorLiteral(red: 0.02708645537, green: 0.8015219569, blue: 0.723786056, alpha: 1)
        polyline.geodesic = true
        polyline.map = mapView
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
