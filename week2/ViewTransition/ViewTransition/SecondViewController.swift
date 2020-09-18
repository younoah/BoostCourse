//
//  SecondViewController.swift
//  ViewTransition
//
//  Created by uno on 2020/09/18.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popToPrev() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
