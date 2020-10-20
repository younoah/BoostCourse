//
//  Indicator.swift
//  BoxOffice
//
//  Created by uno on 2020/10/19.
//

import UIKit

class Indicator {
    let indicatorView = UIActivityIndicatorView()
    
    func showIndicator(_ viewController: UIViewController) {
        viewController.view.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor).isActive = true
        indicatorView.startAnimating()
    }
    
    func stopIndicator(_ viewController: UIViewController) {
        indicatorView.stopAnimating()
    }
}
