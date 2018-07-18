//
//  TrailCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class TrailCell: UICollectionViewCell {
    
    @IBOutlet private weak var trailNameLabel: UILabel!
    @IBOutlet private weak var hikingTimeLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var mapView: UIView!
    
    var map: GMSMapView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        map = createMapView(position: nil)
        mapView.addSubview(map ?? UIView())
        let coverView = UIView(frame: mapView.bounds)
        coverView.backgroundColor = .clear
        mapView.addSubview(coverView)
    }
    
    var trailModel: Trail? {
        didSet {
            if let pathName = trailModel?.attributes?.pathName?.trim() {
                trailNameLabel.text = pathName.isEmpty ? "이름없는 등산로" : pathName
            }
            hikingTimeLabel.text = "\(trailModel?.attributes?.ascendTime ?? 0 + (trailModel?.attributes?.descendTime ?? 0))분"
            distanceLabel.text = "\(trailModel?.attributes?.distance ?? 0)km"
        }
    }
    
    var position: [Result?]? {
        didSet {
            map?.clear()
            let cameraPosition = position?.compactMap { $0 }.first
            map?.camera = GMSCameraPosition.camera(withLatitude: cameraPosition?.posY ?? 0, longitude: cameraPosition?.posX ?? 0, zoom: 13)
            drawPath(position: position)
        }
    }
    
    func createMapView(position: Result?) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: position?.posY ?? 0, longitude: position?.posX ?? 0, zoom: 13)
        let mapView = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.setAllGesturesEnabled(false)
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
        polyline.strokeWidth = 2
        polyline.strokeColor = #colorLiteral(red: 0.02708645537, green: 0.8015219569, blue: 0.723786056, alpha: 1)
        polyline.geodesic = true
        polyline.map = map
    }
}
