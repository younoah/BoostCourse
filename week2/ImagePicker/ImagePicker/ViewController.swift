//
//  ViewController.swift
//  ImagePicker
//
//  Created by uno on 2020/09/18.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- Properties
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK:- view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- methods
    @IBAction func touchUpSelectImageButton(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
   
    
}

// MARK:- ImagePicker Delegate
extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage:UIImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = originalImage
       }
 
        dismiss(animated: true, completion: nil)
    }
    
}
