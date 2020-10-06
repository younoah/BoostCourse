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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.title = "컬렉션"
        
        let nibName = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: cellIdentifier)
        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.sectionInset = UIEdgeInsets.zero //인셋 없애기
//        flowLayout.minimumInteritemSpacing = 5 // 아이템간의 거리는 최소 10
//        flowLayout.minimumLineSpacing = 30 // 아이템의 줄간의 거리는 최소 10
    }
    
}

extension MovieCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}

extension MovieCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
}

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
