//
//  ViewController.swift
//  SignUp
//
//  Created by uno on 2020/09/22.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var idTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserInformation.shared.id?.isEmpty == false {
            idTextField.text = UserInformation.shared.id
        }
        print("뷰윌 어피얼")
    }


}

