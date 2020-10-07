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
    var movies: [Movie] = []
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.title = "리스트"
        
        let nibName = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: cellIdentifier)
        
        getJsonUrl(orderType: "0")
    }

}

// MARK:- Action Sheet
extension MovieTableViewController {
    
    @IBAction func touchUpShowActionSheetButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        
        let reservationRateAction = UIAlertAction(title: "예매율", style: UIAlertAction.Style.default) {
            (action : UIAlertAction) in
            self.getJsonUrl(orderType: "0")
            self.navigationItem.title = "예매율순"
        }
        
        let currationAction = UIAlertAction(title: "큐레이션", style: UIAlertAction.Style.default) {
            (action : UIAlertAction) in
            self.getJsonUrl(orderType: "1")
            self.navigationItem.title = "큐레이션"
        }
        
        let openingDay = UIAlertAction(title: "개봉일", style: UIAlertAction.Style.default) {
            (action : UIAlertAction) in
            self.getJsonUrl(orderType: "2")
            self.navigationItem.title = "개봉일순"
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(reservationRateAction)
        alertController.addAction(currationAction)
        alertController.addAction(openingDay)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
}

// MARK:- Get Movie data
extension MovieTableViewController {
    
    func getJsonUrl(orderType: String) {
        
        if orderType == "0" {
            guard let orderUrl = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type=0") else { return }
            getDatafromUrl(url: orderUrl)
        }
        else if orderType == "1" {
            guard let orderUrl = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type=1") else { return }
            getDatafromUrl(url: orderUrl)
        }
        else if orderType == "2" {
            guard let orderUrl = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type=2") else { return }
            getDatafromUrl(url: orderUrl)
        }
    }
    
    func getDatafromUrl(url: URL) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let moiveResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                self.movies = moiveResponse.movies
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
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
        cell.movieGradeImageView.image = UIImage(named: movie.gradeString)
        cell.movieTitleLabel.text = movie.title
        cell.movieInfoLabel.text = movie.tableDetail
        cell.movieDateLabel.text = movie.date
        
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
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
}
