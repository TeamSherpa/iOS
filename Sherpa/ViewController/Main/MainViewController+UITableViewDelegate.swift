//
//  MainViewController+UITableViewDelegate.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 20..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if questions.count > model.count, indexPath.row == questions.count - 1 {
            return 280
        } else {
            let category = self.category[indexPath.row] ?? .none
            switch category {
            case .education: return 228
            case .news, .mountain: return 300
            case .traffic: return 300
            case .local: return 190
            case .info: return 180
            case .distance: return 220
            default: return 220
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let ipath = IndexPath(row: questions.count - 1, section: 0)
        tableView.scrollToRow(at: ipath, at: .bottom, animated: true)
    }
}
