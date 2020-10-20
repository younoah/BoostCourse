//
//  CommentViewController.swift
//  BoxOffice
//
//  Created by uno on 2020/10/06.
//

import UIKit

class CommentViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var slideBar: UISlider!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var movieGradeImageView: UIImageView!
    var movieID: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSliderAndGradeLabel()
        slideBar.addTarget(self, action: #selector(changeVlaueSlider), for: .valueChanged)
        
        // 탭바 숨기기
        tabBarController?.tabBar.isHidden = true
        
        navigationItem.title = "한줄평 작성"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchUpCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(touchUpDoneButton))

        contentTextView.delegate = self
        contentTextView.text = "한줄평을 작성해주세요."
        contentTextView.textColor = UIColor.lightGray
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didReceivePostCommentNotification(_:)),
            name: API.DidReceivePostCommentNotification,
            object: nil
        )
        
        contentTextView.layer.borderWidth = 1.0
        contentTextView.layer.borderColor = UIColor.orange.cgColor
        contentTextView.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.movieID = CurrentMovieInfo.shared.movieID
        self.movieTitleLabel.text = CurrentMovieInfo.shared.movieName
        self.movieGradeImageView.image = UIImage(named: CurrentMovieInfo.shared.movieGrade ?? "")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK:- Methods
extension CommentViewController {
    
    @objc func didReceivePostCommentNotification(_ noti: Notification){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpDoneButton() {
        if !contentTextView.text.isEmpty && contentTextView.text != "한줄평을 작성해주세요.",
           let userNameName = self.userNameTextField.text,
           !userNameName.isEmpty,
           let movieID = self.movieID {
            let comment = PostComment(
                rating : Double(slideBar.value),
                writer: userNameName,
                movieID: movieID,
                contents: contentTextView.text)
            API.postComment(body: comment)
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "", message: "닉네임 혹은 한줄평이 입력되지 않았습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func changeVlaueSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        gradeLabel.text = "\(currentValue)"
    }
    
    func drawSliderAndGradeLabel() {
        gradeLabel.text = "5"
        slideBar.minimumValue = 0
        slideBar.maximumValue = 10
        slideBar.value = 5
    }
}

// MARK:- Text View Delegate
extension CommentViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentTextView.textColor == UIColor.lightGray {
            contentTextView.text = nil
            contentTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text.isEmpty {
            contentTextView.text = "한줄평을 작성해주세요."
            contentTextView.textColor = UIColor.lightGray
        }
    }
    
}
