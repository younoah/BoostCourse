//
//  ViewController.swift
//  TapGesture
//
//  Created by uno on 2020/09/21.
//

import UIKit

//class ViewController: UIViewController {
//
//    lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.view.addGestureRecognizer(tapRecognizer)
//    }
//
//    // MARK:- Method
//    @IBAction func tapView(_ sender: UIGestureRecognizer) {
//        self.view.endEditing(true)
//    }
//
//}

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        tapRecognizer.delegate = self
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        
        // 여기선 리턴값이 true이든 false 이든 상관은 없다.
        // 이미 이 메서드가 실행된건 사용자의 터치를 인식했기 때문이다.
        return true
    }
    
}

