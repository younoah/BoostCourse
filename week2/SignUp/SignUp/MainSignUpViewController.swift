//
//  MainSignUpViewController.swift
//  SignUp
//
//  Created by uno on 2020/09/22.
//

import UIKit

class MainSignUpViewController: UIViewController, UITextViewDelegate {
    
    // MARK:- Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK:- Properties
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introductionTextView.delegate = self
        
        userImageView.isUserInteractionEnabled = true
        let imageViewTapGestureRecognizer = UITapGestureRecognizer()
        userImageView.addGestureRecognizer(imageViewTapGestureRecognizer)
        imageViewTapGestureRecognizer.addTarget(self, action: #selector(tapImageView))
        
        let viewTapGestureRecognizer = UITapGestureRecognizer()
        self.view.addGestureRecognizer(viewTapGestureRecognizer)
        viewTapGestureRecognizer.addTarget(self, action: #selector(tapView))
        
        cancelButton.addTarget(self, action: #selector(self.cancelSignUpButton),
                               for: UIControl.Event.touchUpInside)
        idTextField.addTarget(self, action: #selector(self.checkFormAndEnableNextButton),
                              for: UIControl.Event.editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(self.checkFormAndEnableNextButton),
                                    for: UIControl.Event.editingDidEnd)
        passwordCheckTextField.addTarget(self, action: #selector(self.checkFormAndEnableNextButton),
                                         for: UIControl.Event.editingDidEnd)
        nextButton.addTarget(self, action: #selector(saveUserInfo), for: UIControl.Event.touchUpInside)
    }
    
    // MARK:- Method
    @objc func tapImageView() {
        present(imagePicker, animated: true, completion: nil)
    }
    @objc func tapView() {
        view.endEditing(true)
    }
    @objc func checkFormAndEnableNextButton() {
        if userImageView.image != nil,
           idTextField.text?.isEmpty == false,
           passwordTextField.text?.isEmpty == false,
           passwordTextField.text == passwordCheckTextField.text,
           introductionTextView.text.isEmpty == false{
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    @objc func saveUserInfo() {
        UserInformation.shared.id = idTextField.text
        UserInformation.shared.password = passwordTextField.text
        UserInformation.shared.introduction = introductionTextView.text
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        checkFormAndEnableNextButton()
    }

}

// MARK:- ImagePicker
extension MainSignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image:UIImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.userImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
        checkFormAndEnableNextButton()
    }
    
}

// MARK:- Button
extension MainSignUpViewController {
    
    // MARK:- CancelButton Method
    @IBAction func cancelSignUpButton() {
        self.navigationController?.popViewController(animated: true)
    }

}
