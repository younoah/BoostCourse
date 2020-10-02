//
//  ViewController.swift
//  Alert
//
//  Created by uno on 2020/10/01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

// MARK:- Alert
extension ViewController {
    @IBAction func touchUpShowAlertButton(_ sender: UIButton) {
        self.showAlertController(style: UIAlertController.Style.alert)
    }
    
    @IBAction func touchUpShowActionSheetButton(_ sender: UIButton) {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    func showAlertController(style: UIAlertController.Style) {
        let alertController = UIAlertController(
            title: "title",
            message: "message",
            preferredStyle: style)
        
        let handler: (UIAlertAction) -> Void
        handler = { (action: UIAlertAction) in
            print("action pressed \(action.title ?? "")")
        }
        
        let okAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: handler)
        
        let cancleAction = UIAlertAction(
            title: "Cancel",
            style: UIAlertAction.Style.cancel,
            handler: handler)
        
        let someAction = UIAlertAction(
            title: "Some",
            style: UIAlertAction.Style.destructive,
            handler: handler)
        
        let anotherAction = UIAlertAction(
            title: "Another",
            style: UIAlertAction.Style.default,
            handler: handler)
        
        alertController.addAction(okAction)
        alertController.addAction(cancleAction)
        alertController.addAction(someAction)
        alertController.addAction(anotherAction)
        
        // 텍스트 필드는 action sheet에서는 사용이 불가능하다.
        // 오직 alert에서만 텍스트 필드를 사용할수 있다.
        alertController.addTextField { field in
            field.placeholder = "플레이스홀더"
            field.textColor = UIColor.red
        }
        
        self.present(alertController,
                     animated: true,
                     completion: {
                        print("Alert controller shown")
        })
    }
}
