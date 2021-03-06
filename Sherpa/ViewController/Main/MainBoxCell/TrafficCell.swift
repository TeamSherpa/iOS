//
//  TrafficCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 7. 14..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class TrafficCell: UICollectionViewCell, CollectionViewModelRepresentable, TMapViewDelegate, TMapPathDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var distanceLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    
    var locationManager:CLLocationManager!
    
    var mapView: TMapView?
    var startPoint: TMapPoint?
    var endPoint: TMapPoint?
    var isDrawedPath = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        TMapTapi.setSKPMapAuthenticationWith(self, apiKey: APIConfiguration.tmapKey)
        
        setupMap()
    }
    
    func setupMap() {
        mapView = TMapView.init(frame: mapContainerView.bounds)
        mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView?.layer.cornerRadius = 3
        mapView?.layer.masksToBounds = true
        
        mapView?.setSKTMapApiKey(APIConfiguration.tmapKey)
        mapView?.delegate = self
        
        mapContainerView.addSubview(mapView ?? UIView())
    }
    
    func setPath(long: Double, lat:Double, currentlong: Double, currentlat: Double) {
        //tmap 경로 생성
        let path = TMapPathData()
        path.delegate = self
        startPoint = TMapPoint(lon: currentlong, lat: currentlat)
        endPoint = TMapPoint(lon: long, lat: lat)
        
        let polyLine: TMapPolyLine? = path.find(with: CAR_PATH, start: startPoint, end: endPoint)
       
        polyLine?.lineColor_ = #colorLiteral(red: 0, green: 0.3414386511, blue: 0.332439363, alpha: 1)
        polyLine?.lineWidth_ =  3
        
        guard polyLine != nil else {
            return
        }
        
        guard polyLine?.getPoint().count != 0 else {
            return
        }
        
        guard let info = path.findTimeMachineCarPath(withStart: startPoint, end: endPoint, isStartTime: true, time: Date(), wayPoints: nil) else {
            return
        }
        let infoarray = JSON(info[AnyHashable("features")].unsafelyUnwrapped)
      
        let jsonString = infoarray[0]["properties"].description
        let jsonData = jsonString.data(using: .utf8) ?? Data()
        do {
            let result = try JSONDecoder().decode(Traffic.self, from: jsonData)
            let time = Int(gino(result.totalTime) / 60)
            if time >= 60 {
                timeLB.text = "· 소요시간 약\(String(Int(time/60)))시간\(time%60)분"
            } else {
                timeLB.text = "· 소요시간 약\(String(time))분"
            }
            distanceLB.text = "· 이동거리 \(String(Int(gino(result.totalDistance) / 1000)))Km"
            
          
        } catch {
            print("정보를 가져올수 없습니다.")

        }
        let start = polyLine?.getPoint()[0] as? TMapPoint
        let end = polyLine?.getPoint().last as? TMapPoint
        
        let startMarkerItem = TMapMarkerItem(tMapPoint: start)
        startMarkerItem?.setIcon(UIImage(named: "marker.png"), anchorPoint: CGPoint(x: 0.4, y: 1.0))
        
        let endMarkerItem = TMapMarkerItem(tMapPoint: end)
        endMarkerItem?.setIcon(UIImage(named: "end.png"), anchorPoint: CGPoint(x: 0.5, y: 1.0))
        mapView?.setTMapPathIconStart(startMarkerItem, end: endMarkerItem)
        
        if (polyLine != nil) {
            mapView?.addTMapPath(polyLine)
        }
        
        let mapInfo = mapView?.getDisplayTMapInfo(polyLine?.getPoint())
        
        mapView?.setCenter(mapInfo?.mapPoint)
        mapView?.zoomLevel = gino(mapInfo?.zoomLevel)
        mapView?.setUserScrollZoomEnable(true)
        
        isDrawedPath = true
    }
    
    var model: ModelTransformable? {
        didSet {
            if let location = model as? MountainLocation, !isDrawedPath {
                setPath(long:gdno(Double(location.longitude)), lat: gdno(Double(location.latitude)), currentlong:gdno(locationManager.location?.coordinate.longitude) ,currentlat:gdno(locationManager.location?.coordinate.latitude))
            }
        }
    }
    
    func didSelectedAction() {
        guard let coordinate = startPoint?.coordinate else {
            return
        }
        TMapTapi.invokeRoute("관악산", coordinate: coordinate)
    }
}

extension TrafficCell: TMapTapiDelegate { }
