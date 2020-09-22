//
//  AdditionalSignUpViewController.swift
//  SignUp
//
//  Created by uno on 2020/09/22.
//

import UIKit

class AdditionalSignUpViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthDateLabel.text = dateFormatter.string(from: datePicker.date)
        
        let viewTapGestureRecognizer = UITapGestureRecognizer()
        self.view.addGestureRecognizer(viewTapGestureRecognizer)
        viewTapGestureRecognizer.addTarget(self, action: #selector(tapView))
        
        cancelButton.addTarget(self, action: #selector(self.cancelSignUpButton), for: UIControl.Event.touchUpInside)
        previousButton.addTarget(self, action: #selector(self.backToPreviousButton), for: UIControl.Event.touchUpInside)
        datePicker.addTarget(self, action: #selector(self.didDatePickerValueChange), for: UIControl.Event.valueChanged)
        phoneNumberTextField.addTarget(self, action: #selector(self.checkFormAndEnableSignUpButton), for: UIControl.Event.editingDidEnd)
        signUpButton.addTarget(self, action: #selector(saveUserInfo), for: UIControl.Event.touchUpInside)
    }
    
    // MARK:- Method
    @objc func tapView() {
        view.endEditing(true)
    }
    @objc func cancelSignUpButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func backToPreviousButton() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func didDatePickerValueChange() {
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        birthDateLabel.text = dateString
    }
    @objc func checkFormAndEnableSignUpButton() {
        if phoneNumberTextField.text?.isEmpty == false {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
    @objc func saveUserInfo() {
        UserInformation.shared.phoneNumber = phoneNumberTextField.text
        UserInformation.shared.birthDate = datePicker.date
        completeSignUp()
    }
    func completeSignUp() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
