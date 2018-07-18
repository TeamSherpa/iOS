//
//  InfoCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 7. 18..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

class MountainInfoCell: UICollectionViewCell, CollectionViewModelRepresentable {
    
    @IBOutlet private weak var mountainImageView: UIImageView!
    @IBOutlet private weak var mountainNameLabel: UILabel!
    @IBOutlet private weak var mountainDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
    }
    
    var model: ModelTransformable? {
        didSet {
            let model = self.model as! Mountain
            mountainNameLabel.text = model.name
            mountainDescriptionLabel.text = model.detail
            if let url = URL(string: "http://" + (model.imageURL)) {
                mountainImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "mountainDetault"))
            }
        }
    }
}
