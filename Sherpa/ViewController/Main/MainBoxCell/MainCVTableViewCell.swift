//
//  MainCVTableViewCell.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 3..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class MainCVTableViewCell: UITableViewCell {

    var responseVO = [Mountain]()
    
    @IBOutlet weak var orderCV: UICollectionView!
    @IBOutlet weak var voiceRecodeLB: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var resultCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var model = [ModelTransformable]() {
        didSet {
            orderCV.reloadData()
        }
    }
    
    var didSelectMountainCell: ((ModelTransformable?) -> Void)?
    
    var category: Category?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        orderCV.delegate = self
        orderCV.dataSource = self
        
        orderCV.register(UINib(nibName: "ArticleCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ArticleCollectionViewCell")
        orderCV.register(UINib(nibName: "EducationCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "EducationCollectionViewCell")
        orderCV.register(UINib(nibName: "MountainCell", bundle: .main), forCellWithReuseIdentifier: "MountainCell")
    }
}

extension MainCVTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let category = category else {
            return .zero
        }
        switch category {
        case .education:
            resultCollectionViewHeightConstraint.constant = 163
            layoutIfNeeded()
            return CGSize(width: 129, height: 150)
        case .news, .mountain:
            resultCollectionViewHeightConstraint.constant = 253
            layoutIfNeeded()
            return CGSize(width: 170, height: 220)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
    }
}

extension MainCVTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewModelRepresentable
        cell.didSelectedAction()
        if cell.model is Mountain {
            didSelectMountainCell?(cell.model)
        }
    }
}

extension MainCVTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count > 5 ? 5 : model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let identifier = category?.cellIdentifier, identifier.isNotEmpty else {
            return UICollectionViewCell()
        }
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionViewModelRepresentable
        cell.model = model[indexPath.item]
        return cell as! UICollectionViewCell
    }
}



