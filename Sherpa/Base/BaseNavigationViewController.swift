//
//  BaseNavigationViewController.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func setNavigationBar() {
        navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationBar.shadowImage = UIImage()
        let leftItem = UIBarButtonItem(customView: UIImageView(image: #imageLiteral(resourceName: "naviLogo")))
        topViewController?.navigationItem.leftBarButtonItem = leftItem
    }
}
