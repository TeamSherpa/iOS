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
        
        
        setDelegate()
        registerCell()
    }
    
    func setDelegate() {
        orderCV.delegate = self
        orderCV.dataSource = self
    }
    
    func registerCell() {
        orderCV.register(UINib(nibName: "ArticleCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ArticleCollectionViewCell")
        orderCV.register(UINib(nibName: "EducationCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "EducationCollectionViewCell")
        orderCV.register(UINib(nibName: "MountainCell", bundle: .main), forCellWithReuseIdentifier: "MountainCell")
        orderCV.register(UINib(nibName: "TrafficCell", bundle: .main), forCellWithReuseIdentifier: "TrafficCell")
        orderCV.register(UINib(nibName: "LocalCell", bundle: .main), forCellWithReuseIdentifier: "LocalCell")
        orderCV.register(UINib(nibName: "MountainInfoCell", bundle: .main), forCellWithReuseIdentifier: "MountainInfoCell")
        orderCV.register(UINib(nibName: "DistanceCell", bundle: .main), forCellWithReuseIdentifier: "DistanceCell")
        orderCV.register(UINib(nibName: "ResultFailCell", bundle: .main), forCellWithReuseIdentifier: "ResultFailCell")
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
        case .traffic:
            resultCollectionViewHeightConstraint.constant = 240
       
            layoutIfNeeded()
            return CGSize(width: UIScreen.main.bounds.width - 30, height: 210)
        case .local:
            resultCollectionViewHeightConstraint.constant = 123
          
            layoutIfNeeded()
            return CGSize(width: 180, height: 110)
        case .info:
            resultCollectionViewHeightConstraint.constant = 113
           
            layoutIfNeeded()
            return CGSize(width: UIScreen.main.bounds.width - 30, height: 100)
        case .distance:
            resultCollectionViewHeightConstraint.constant = 153
            
            layoutIfNeeded()
            return CGSize(width: UIScreen.main.bounds.width - 30, height: 140)
        case .none:
            resultCollectionViewHeightConstraint.constant = 153
            
            layoutIfNeeded()
            return CGSize(width: UIScreen.main.bounds.width - 30, height: 140)
            
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
        print(11111)
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionViewModelRepresentable
        cell.model = model[indexPath.item]
        return cell as! UICollectionViewCell
    }
}
