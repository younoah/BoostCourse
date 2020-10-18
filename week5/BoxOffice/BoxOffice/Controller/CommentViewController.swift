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
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let comment = PostComment(
            rating : Double(4),
            writer: "ㅎㅎ!!안녕!!ㅎㅎ",
            movieID: "5a54c286e8a71d136fb5378e",
            contents: "!!!안뇽 댓글 테스트!")
        
        API.postComment(body: comment)
        navigationController?.popViewController(animated: true)
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
