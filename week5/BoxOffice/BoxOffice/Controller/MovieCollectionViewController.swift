//
//  MovieCollectionViewController.swift
//  BoxOffice
//
//  Created by uno on 2020/10/06.
//

import UIKit

class MovieCollectionViewController: UIViewController {
    
    // MARK:- properties
    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier = "movieCell"
    var movies: [Movie] = []

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.title = "컬렉션"
        
        let nibName = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: cellIdentifier)
        
        getJsonUrl(orderType: "0")
        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.sectionInset = UIEdgeInsets.zero //인셋 없애기
//        flowLayout.minimumInteritemSpacing = 5 // 아이템간의 거리는 최소 10
//        flowLayout.minimumLineSpacing = 30 // 아이템의 줄간의 거리는 최소 10
    }
    
}

// MARK:- Action Sheet
extension MovieCollectionViewController {
    
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

// MARK:- Get Data
extension MovieCollectionViewController {
    
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
                    self.collectionView.reloadData()
                }
                
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
}

// MARK:- Collection View DataSource
extension MovieCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = movies[indexPath.item]
        cell.movieGradeImageView.image = UIImage(named: movie.gradeString)
        cell.movieTitleLabel.text = movie.title
        cell.movieInfoLabel.text = movie.collectionDetail
        cell.movieDateLabel.text = movie.date
        
        DispatchQueue.global().async {
            guard let movieImageURL = URL(string: movie.imageURL) else { return }
            guard let imageData = try? Data(contentsOf: movieImageURL) else { return }

            DispatchQueue.main.async {
                if let index = collectionView.indexPath(for: cell) {
                    if index.item == indexPath.item {
                        cell.movieImageView.image = UIImage(data: imageData)
                        cell.setNeedsLayout()
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
        
        return cell
    }
    
    
}

// MARK:- Collection View Delegate
extension MovieCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
}

// MARK:- Collection View Delegate Flow Layout
extension MovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 400)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 50, height: 50)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: 50, height: 50)
//    }
    
}
