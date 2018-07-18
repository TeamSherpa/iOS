//
//  TrafficCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 7. 14..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class TrafficCell: UICollectionViewCell, CollectionViewModelRepresentable {

    @IBOutlet weak var mapContainerView: UIView!
    var mapView: TMapView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
        setupMap()
    }
    
    func setupMap() {
        mapView = TMapView(frame: mapContainerView.bounds)
        mapView?.setSKTMapApiKey(APIConfiguration.tmapKey)
        mapContainerView.addSubview(mapView ?? UIView())
    }
    
    var model: ModelTransformable? {
        didSet {
            if let location = model as? MountainLocation {
                
            }
        }
    }
}
