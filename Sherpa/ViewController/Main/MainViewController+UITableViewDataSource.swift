//
//  MainViewController+UITableViewDataSource.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 20..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoxCell") as! MainCVTableViewCell
        
        if questions.count > model.count, indexPath.row == questions.count - 1 {
            cell.voiceRecodeLB.text = questions[indexPath.row]
            cell.indicator.isHidden = false
            cell.indicator.startAnimating()
        } else {
            cell.voiceRecodeLB.text = questions[indexPath.row]
            cell.model = model[indexPath.row]
            cell.category = category[indexPath.row]
            cell.indicator.stopAnimating()
            cell.indicator.isHidden = true
            cell.didSelectMountainCell = { [weak self] model in
                self?.performSegue(withIdentifier: DetailMountainViewController.identifier, sender: model)
            }
        }
        
        return cell
    }
}
