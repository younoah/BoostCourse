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
        
        navigationItem.title = "예매율"
        
        let nibName = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: cellIdentifier)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didRecevieMovieCollectionNotification),
            name: API.DidReceiveMoviesNotification, object: nil)
        
        API.getMovies(orderType: MovieSort.shared.orderTypeNumber)
        
        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.sectionInset = UIEdgeInsets.zero //인셋 없애기
//        flowLayout.minimumInteritemSpacing = 5 // 아이템간의 거리는 최소 10
//        flowLayout.minimumLineSpacing = 30 // 아이템의 줄간의 거리는 최소 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}

// MARK:- Methods
extension MovieCollectionViewController {
    
    @objc func didRecevieMovieCollectionNotification(_ noti:Notification){
        guard let movies:[Movie] = noti.userInfo?["movies"] as? [Movie] else {return}
        self.movies = movies
        collectionView.reloadData()
    }
    
    @IBAction func touchUpSettingButton() {
        MovieSortActionSheet.touchUpShowActionSheetButton(self)
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
