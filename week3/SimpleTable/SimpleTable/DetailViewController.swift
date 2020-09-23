//
//  DetailViewController.swift
//  SimpleTable
//
//  Created by uno on 2020/09/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var textLabel: UILabel!
    
    // 이전 뷰컨에서 넘겨온 데이터를 담을 변수
    var textToSet: String?
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 이전 뷰컨에서 넘겨온 데이터를 담은 변수로 세팅하기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.textLabel.text = self.textToSet
    }

}
