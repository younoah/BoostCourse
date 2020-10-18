//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by uno on 2020/10/06.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    var movie: MovieDetail?
    var comments: [Comment] = []
    
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
//        tableView.isHidden = true
        
        navigationItem.title = "영화제목"
        
        tableView.register(
            UINib(nibName: "MovieDetailInfomationTableViewCell", bundle: nil),
            forCellReuseIdentifier: "movieDetailInformationCell"
        )
        tableView.register(
            UINib(nibName: "MovieSynopsisTableViewCell", bundle: nil),
            forCellReuseIdentifier: "movieSynopsisCell"
        )
        tableView.register(
            UINib(nibName: "MovieDirectorTableViewCell", bundle: nil),
            forCellReuseIdentifier: "movieDirectorCell"
        )
        tableView.register(
            UINib(nibName: "CommentTableViewCell", bundle: nil),
            forCellReuseIdentifier: "commentCell"
        )
        tableView.register(
            UINib(nibName: "CommentSectionHeader", bundle: nil),
            forCellReuseIdentifier: "commentHeader"
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didReceiveMovieDetialNotification(_:)),
            name: API.DidReceiveMovieDetailNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didReceiveCommentsNotification(_:)),
            name: API.DidReceiveCommentsNotification,
            object: nil
        )
        
        API.getMovieDetailInformation(movieID: "5a54c286e8a71d136fb5378e")
        API.getComments(movieID: "5a54c286e8a71d136fb5378e")

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
extension MovieDetailViewController {
    
    @objc func didReceiveMovieDetialNotification(_ noti: Notification){
        guard let movie = noti.userInfo?["movie"] as? MovieDetail else {return}
      
        self.movie = movie
//        DispatchQueue.main.async {
        self.tableView.reloadData()
//        }
    }
    
    @objc func didReceiveCommentsNotification(_ noti: Notification){
        guard let comment = noti.userInfo?["comments"] as? CommentResponse else {return}
      
        self.comments = comment.comments
//        DispatchQueue.main.async {
        self.tableView.reloadData()
//        }
    }
    
}

// MARK:- Table View DataSource
extension MovieDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2:
            return 1
        case 3:
            return comments.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionIndex = indexPath.section
        let movie = self.movie
        
        switch sectionIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "movieDetailInformationCell",
                    for: indexPath) as? MovieDetailInfomationTableViewCell else {
                return UITableViewCell()
            }
            cell.movieTitleLabel.text = movie?.title
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "movieSynopsisCell",
                    for: indexPath) as? MovieSynopsisTableViewCell else {
                return UITableViewCell()
            }
            cell.synopsisLabel.text = movie?.synopsis
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "movieDirectorCell",
                    for: indexPath) as? MovieDirectorTableViewCell else {
                return UITableViewCell()
            }
            cell.directorLabel.text = movie?.director
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "commentCell",
                    for: indexPath) as? CommentTableViewCell else {
                return UITableViewCell()
            }
            cell.writerNameLabel.text = comments[indexPath.row].writer
            cell.contentLabel.text = comments[indexPath.row].contents
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

// MARK:- Table View Delegate
extension MovieDetailViewController: UITableViewDelegate {
    
    // 댓글 헤더
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: CommentSectionHeader.self)) as? CommentSectionHeader else {
                return UIView()
            }
            return header

        }else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 300
        case 2:
            return 100
        case 3:
            return 100
        default:
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let commentViewController = self.storyboard?.instantiateViewController(identifier: "commentViewController") as? CommentViewController else {
            return
        }
        
        navigationController?.pushViewController(commentViewController, animated: true)
    }
    
}
