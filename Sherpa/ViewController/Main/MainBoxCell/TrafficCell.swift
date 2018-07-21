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
    }
    
    func setupMap(long:Double ,lat:Double ,currentlong:Double ,currentlat:Double) {
        // tmap 생성
        mapView = TMapView.init(frame: mapContainerView.bounds)
        mapView?.layer.cornerRadius = 3
        mapView?.layer.masksToBounds = true
        
        guard let MapView = mapView else {
            print("[Main] TMap을 생성하는 데 실패했습니다")
            return
        }
        MapView.setSKTMapApiKey(APIConfiguration.tmapKey)
        
        mapContainerView.addSubview(MapView)
        mapContainerView.isUserInteractionEnabled = true
        MapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        MapView.delegate = self
        
        
        //tmap 경로 생성
        let path = TMapPathData()
        path.delegate = self
        startPoint = TMapPoint(lon:currentlong , lat: currentlat)
        endPoint = TMapPoint(lon:long , lat: lat)
        
        let polyLine: TMapPolyLine? = path.find(with: CAR_PATH, start: startPoint, end: endPoint)
       
        polyLine?.lineColor_ = #colorLiteral(red: 0, green: 0.3414386511, blue: 0.332439363, alpha: 1)
        polyLine?.lineWidth_ =  3
        
        guard polyLine != nil else {
            return
        }
        
        guard polyLine?.getPoint().count != 0 else {
            return
        }
        
        var info = path.findTimeMachineCarPath(withStart: startPoint, end: endPoint, isStartTime: true, time: Date(), wayPoints: nil)
        let infoarray = JSON(info![AnyHashable("features")].unsafelyUnwrapped)
      
        let jsonString = infoarray[0]["properties"].description
        let jsonData = jsonString.data(using: .utf8) ?? Data()
        do {
            let result = try JSONDecoder().decode(Traffic.self, from: jsonData)
            let time = Int(gino(result.totalTime) / 60)
            if time >= 60{
                timeLB.text = "· 소요시간 약\(String(Int(time/60)))시간\(time%60)분"
                
            }
            timeLB.text = "· 소요시간 약\(String(time))분"
            distanceLB.text = "· 이동거리 \(String(Int(gino(result.totalDistance) / 1000)))Km"
            
          
        } catch {
            print("정보를 가져올수 없습니다.")

        }
        let start = polyLine?.getPoint()[0] as? TMapPoint
        let end = polyLine?.getPoint().last as? TMapPoint
        
        let startMarkerItem = TMapMarkerItem(tMapPoint: start)
        startMarkerItem?.setIcon(UIImage(named: "start.png"), anchorPoint: CGPoint(x: 0.4, y: 1.0))
        
        let endMarkerItem = TMapMarkerItem(tMapPoint: end)
        endMarkerItem?.setIcon(UIImage(named: "end.png"), anchorPoint: CGPoint(x: 0.5, y: 1.0))
        MapView.setTMapPathIconStart(startMarkerItem, end: endMarkerItem)
        
        
        
        if (polyLine != nil) {
            MapView.addTMapPath(polyLine)
        }
        
        let mapInfo = MapView.getDisplayTMapInfo(polyLine?.getPoint())
        
        MapView.setCenter(mapInfo?.mapPoint)
        MapView.zoomLevel = gino(mapInfo?.zoomLevel)
        MapView.setUserScrollZoomEnable(true)
      
    }
    
    var model: ModelTransformable? {
        didSet {
            if let location = model as? MountainLocation {
                setupMap(long:gdno(Double(location.longitude)), lat: gdno(Double(location.latitude)), currentlong:gdno(locationManager.location?.coordinate.longitude) ,currentlat:gdno(locationManager.location?.coordinate.latitude))
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
