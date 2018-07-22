//
//  EducationCollectionViewCell.swift
//  Sherpa
//
//  Created by DanBee on 2018. 6. 20..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class EducationCollectionViewCell: UICollectionViewCell, CollectionViewModelRepresentable {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var programTitleLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
    }
    
    var model: ModelTransformable? {
        didSet {
            let education = model as! Education
            programTitleLabel.text = education.name
            placeLabel.text = education.address
            periodLabel.text = education.period
            categoryLabel.text = education.category?.split(separator: ",")
                                                    .map { "#\($0.trimmingCharacters(in: .whitespaces))"}
                                                    .joined(separator: " ")
        }
    }
    
    func didSelectedAction() {
        let education = model as! Education
        guard let educationName = education.name else {
            return
        }
        let url = "https://search.naver.com/search.naver?query=\(educationName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
