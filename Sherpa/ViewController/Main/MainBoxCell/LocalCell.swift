//
//  LocalCell.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 7. 18..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class LocalCell: UICollectionViewCell, CollectionViewModelRepresentable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var telephoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
    }
    
    var model: ModelTransformable? {
        didSet {
            if let local = model as? Local {
                titleLabel.text = local.title
                descriptionLabel.text = local.description.isNotEmpty ? local.description : "클릭하여 상세정보 이동"
                telephoneLabel.text = local.telephone.isNotEmpty ? local.telephone : "번호정보없음"
            }
        }
    }
    
    func didSelectedAction() {
        let local = model as! Local
        if let url = URL(string: local.link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
