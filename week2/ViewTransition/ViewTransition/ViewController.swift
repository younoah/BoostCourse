//
//  ViewController.swift
//  ViewTransition
//
//  Created by uno on 2020/09/18.
//

import UIKit

class ViewController: UIViewController {

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("뷰컨틀로러의 뷰가 메모리에 로드 됨")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("뷰컨트롤러의 뷰가 화면에 보여질 예정")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("뷰컨트롤러의 뷰가 화며에 보여짐")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("뷰컨틀롤러의 뷰가 화면에 사라질 예정")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("뷰컨트롤러의 뷰가 화면에서 사라짐")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("뷰컨트롤러의 뷰가 서브뷰를 레이아웃 하려함")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("뷰컨트롤러의 뷰가 서브뷰를 레이아웃 함")
    }


}

