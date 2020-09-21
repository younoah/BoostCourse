//
//  SecondViewController.swift
//  ViewTransition
//
//  Created by uno on 2020/09/18.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK:- properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    //MARK:- 뷰 상태 변화 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("두번째 뷰컨틀로러의 뷰가 메모리에 로드 됨")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameLabel.text = UserInformation.shared.name
        self.ageLabel.text = UserInformation.shared.age
        
        print("두번째 뷰컨트롤러의 뷰가 화면에 보여질 예정")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("두번째 뷰컨트롤러의 뷰가 화며에 보여짐")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("두번째 뷰컨틀롤러의 뷰가 화면에 사라질 예정")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("두번째 뷰컨트롤러의 뷰가 화면에서 사라짐")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("두번째 뷰컨트롤러의 뷰가 서브뷰를 레이아웃 하려함")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("두번째 뷰컨트롤러의 뷰가 서브뷰를 레이아웃 함")
    }
    
    // MARK:- Action Method
    @IBAction func popToPrev() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
