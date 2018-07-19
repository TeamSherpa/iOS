//
//  ResultFailCell.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 7. 19..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class ResultFailCell: UICollectionViewCell ,CollectionViewModelRepresentable{

   
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
    }
    
    var model: ModelTransformable? {
        didSet {
            let distance = model as? Distance
           
        }
    }
}
