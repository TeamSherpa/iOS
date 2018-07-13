//
//  MountainCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 24..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class MountainCell: UICollectionViewCell, CollectionViewModelRepresentable {
    
    @IBOutlet private weak var mountainImageView: UIImageView!
    @IBOutlet private weak var mountainNameLabel: UILabel!
    @IBOutlet private weak var mountainLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
    }
    
    var model: ModelTransformable? {
        didSet {
            if let mountain = model as? Mountain {
                mountainNameLabel.text = mountain.name
                mountainLocationLabel.text = mountain.address
                if let url = URL(string: "http://" + mountain.imageURL) {
                    mountainImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "mountainDetault"))
                }
            }
        }
    }
}
