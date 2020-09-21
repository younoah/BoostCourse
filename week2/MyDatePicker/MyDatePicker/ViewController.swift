//
//  ViewController.swift
//  MyDatePicker
//
//  Created by uno on 2020/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- Prroperties
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        //데이트포맷터가 기본적으로 제공하는 date스타일과, time스타일 형식
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .medium
        // 데이트 포맷 형식 내가 지정하기
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        return formatter
    }()
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
    }
    
    // MARK:- Method
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
    }

}

