//
//  ArticleCollectionViewCell.swift
//  Sherpa
//
//  Created by DanBee on 2018. 6. 18..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

protocol CollectionViewModelRepresentable {
    var model: ModelTransformable? { get set }
    func didSelectedAction()
}

extension CollectionViewModelRepresentable {
    func didSelectedAction() { }
}

extension UICollectionViewCell {
    
     func setShadow() {
        contentView.layer.cornerRadius = 3
        contentView.layer.masksToBounds = true
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 3
        layer.masksToBounds = false
     }
}

class ArticleCollectionViewCell: UICollectionViewCell, CollectionViewModelRepresentable {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
    }
    
    var model: ModelTransformable? {
        didSet {
            let article = model as! Article
            timeLabel.text = Date.formatDate(date: article.pubDate)
            titleLabel.text = article.title
            bodyLabel.text = article.description
        }
    }
    
    func didSelectedAction() {
        let article = model as! Article
        if let url = URL(string: article.link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
