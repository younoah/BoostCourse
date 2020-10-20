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
    var movieID: String?
    var movie: MovieDetail?
    var comments: [Comment] = []
    let indicator = Indicator()
//    let indicatorView = UIActivityIndicatorView()
    let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
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

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
        // 아래는 뷰디드로드로에 정의하면 다음 뷰컨에서 팝되어 해당뷰컨으로 올때 인디케이터가 동작을 멈추지않는다.
        // 유저가 댓글을 입력하고 팝되었을때 데이터를 다시 로드해야하기 때문에 뷰디드어피얼에 있어야한다.
//        showIndicator()
        indicator.showIndicator(self)
        self.movieID = CurrentMovieInfo.shared.movieID
        guard let movieID = self.movieID else { return }
        API.getMovieDetailInformation(movieID: movieID)
        API.getComments(movieID: movieID)
        
    }

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
    
//    func showIndicator() {
//        view.addSubview(indicatorView)
//        indicatorView.translatesAutoresizingMaskIntoConstraints = false
//        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        indicatorView.startAnimating()
//    }
    
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
            // 언래핑 수정하기
            cell.movieGradeImageView.image = UIImage(named: movie?.gradeString ?? "")
            cell.movieDateLabel.text = movie?.date
            // 언래핑 수정하기
            cell.movieUserRatingLabel.text = String(movie?.userRating ?? 0.0)
            cell.movieAudienceLabel.text = String(movie?.audience ?? 0)
            DispatchQueue.global().async {
                guard let movie = movie else { return }
                guard let imageURL: URL = URL(string: movie.image) else { return }
                guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
                DispatchQueue.main.async {
                    if let index: IndexPath = tableView.indexPath(for: cell) {
                        if index.row == indexPath.row {
                            cell.movieImageView?.image = UIImage(data: imageData)
                            cell.setNeedsLayout()
                            cell.layoutIfNeeded()
                            self.indicator.stopIndicator(self)
                        }
                    }
                }
            }
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
            cell.movieGradeLabel.text = "평점 : \(comments[indexPath.row].rating)"
            cell.dateTimeLabel.text = "\(formatter.string(from: Date(timeIntervalSince1970: comments[indexPath.row].timestamp)))"
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

        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 260
        case 1:
            return UITableView.automaticDimension
        case 2:
            return 100
        case 3:
            return 100
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let commentViewController = self.storyboard?.instantiateViewController(identifier: "commentViewController") as? CommentViewController else {
            return
        }
        
        navigationController?.pushViewController(commentViewController, animated: true)
    }
    
}
