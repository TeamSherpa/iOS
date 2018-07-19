//
//  DistanceCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 7. 19..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class DistanceCell: UICollectionViewCell, CollectionViewModelRepresentable {
    
    @IBOutlet private weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
    }
    
    var model: ModelTransformable? {
        didSet {
            let distance = model as? Distance
            distanceLabel.text = distance?.distance
        }
    }
}
