//
//  ViewController.swift
//  FriendsCollection
//
//  Created by uno on 2020/09/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
//    var numberOfCell: Int = 10
    let cellIdentifier: String = "cell"
    var friendsArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        
        let cellNib = UINib(nibName: "FriendCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
        
        let headerNib = UINib(nibName: "HeaderCollectionReusableView", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "friends") else { return }
        
        do {
            friendsArray = try jsonDecoder.decode([Friend].self, from: dataAsset.data)
        } catch {
            print(error)
        }
        
        // MARK:- 컬렉션뷰 플로우 레이아웃
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero //인셋 없애기
        flowLayout.minimumInteritemSpacing = 10 // 아이템간의 거리는 최소 10
        flowLayout.minimumLineSpacing = 30 // 아이템의 줄간의 거리는 최소 10
//        flowLayout.itemSize = CGSize(width: 100, height: 100)
        // 한줄에 2개씩 배치하는것이 목표
        // UIScreen은 해당 단말기의 크기(해상도)이다.
//        let halfWidth: CGFloat = UIScreen.main.bounds.width / 2.0
//        flowLayout.estimatedItemSize = CGSize(width: 150, height: 150) // 예상사이즈를 제시하여 이렇게 사이즈를 해바라 라고 제시한다.
        //헤더 푸터 활성화
//        flowLayout.sectionHeadersPinToVisibleBounds = true
//        flowLayout.sectionFootersPinToVisibleBounds = true
        collectionView.collectionViewLayout = flowLayout
//        굳이 리로드 해야할까?
//        collectionView.reloadData()
    }

}

// MARK:- 컬렉션뷰 데이터소스
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return friendsArray.count
        case 1:
            return friendsArray.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell : FriendCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? FriendCollectionViewCell else {
            return UICollectionViewCell()
        }
        let friend: Friend = friendsArray[indexPath.item]

        if indexPath.section == 0 {
            cell.nameAgeLabel.text = friend.nameAndAge
            cell.addressLabel.text = friend.fullAddress
        } else {
            cell.nameAgeLabel.text = friend.nameAndAge
            cell.addressLabel.text = friend.fullAddress
        }
        return cell
    }
    
}

// MARK:- 컬렉션뷰 델리게이트
extension ViewController: UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        numberOfCell += 1
//        collectionView.reloadData()
//    }
    
}

// MARK:- 컬렉션뷰 델리게이트 플로우 레이아웃
extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
}
