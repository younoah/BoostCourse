//
//  ViewController.swift
//  BoxOffice
//
//  Created by uno on 2020/10/06.
//

import UIKit

class MovieTableViewController: UIViewController {
    
    // MARK:- properties
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "movieCell"
    let indicator = Indicator()
    var movies: [Movie] = []
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            UINib(nibName: "MovieTableViewCell", bundle: nil),
            forCellReuseIdentifier: cellIdentifier
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didReceiveMoviesNotification(_:)),
            name: API.DidReceiveMoviesNotification,
            object: nil
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        indicator.showIndicator(self)
        navigationItem.title = MovieSort.shared.orderTypesString[MovieSort.shared.orderTypeNumber]
        API.getMovies(orderType: MovieSort.shared.orderTypeNumber)
    }

}

// MARK:- Methods
extension MovieTableViewController {
    
    @objc func didReceiveMoviesNotification(_ noti: Notification){
        guard let movies = noti.userInfo?["movies"] as? [Movie] else {return}
      
        self.movies = movies
//        DispatchQueue.main.async {
        self.tableView.reloadData()
//        }
    }
    
    @IBAction func touchUpSettingButton() {
        MovieSortActionSheet.touchUpShowActionSheetButton(self)
    }
    
}

// MARK:- TableView DataSource
extension MovieTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cellIdentifier,
                for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.movieTitleLabel.text = movie.title
        cell.movieInfoLabel.text = movie.tableDetail
        cell.movieDateLabel.text = movie.date
        cell.movieGradeImageView?.image = UIImage(named: movie.gradeString)
        
        //MARK: Threads
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movie.imageURL) else { return }
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
    }
    
}

// MARK:- TableView Delegate
extension MovieTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieDetailViewController = self.storyboard?.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }

        CurrentMovieInfo.shared.movieID = movies[indexPath.row].id
        CurrentMovieInfo.shared.movieName = movies[indexPath.row].title
        CurrentMovieInfo.shared.movieGrade = movies[indexPath.row].gradeString
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
}
