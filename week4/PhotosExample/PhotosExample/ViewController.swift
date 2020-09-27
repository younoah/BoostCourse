//
//  ViewController.swift
//  PhotosExample
//
//  Created by uno on 2020/09/26.
//

import UIKit
import Photos

class ViewController: UIViewController, PHPhotoLibraryChangeObserver {
    
    // MARK:- 프로퍼티
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    

    // MARK:- 뷰의 상태 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가됨")
            self.requestCollection()
            self.tableView.reloadData()
        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    print("사용자가 허용함")
                    self.requestCollection()
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        case .limited:
            print("버전업으로 새로 추가된 내용 limited")
        @unknown default:
            print("unknown default")
        }
        // 포토라이브러리가 변화될때마다 포토라이브러리디드체인지 딜리게이트 메서드가 호출된다.
        PHPhotoLibrary.shared().register(self)
    }
    
    // MARK:- 사진첩에서 컬렉션 요청
    func requestCollection() {
        let cameraRoll: PHFetchResult<PHAssetCollection> =
            PHAssetCollection.fetchAssetCollections(
                with: .smartAlbum,
                subtype: .smartAlbumUserLibrary,
                options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else{
            return
        }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    }
    
    // 포토라이브러리의 변화가 생기때 실행되는 델리게이트 메서드
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {
            return
        }
        
        fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        }
    }

}

// MARK:- table view delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: self.cellIdentifier,
            for: indexPath)
        
        let asset: PHAsset = fetchResult.object(at: indexPath.row)
        
//        let options: PHImageRequestOptions = PHImageRequestOptions()

//        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        
        imageManager.requestImage(
            for: asset,
            targetSize: CGSize(width: 30, height: 30),
            contentMode: .aspectFill,
            options: nil,
            resultHandler: { image, _ in cell.imageView?.image = image})
        
        return cell
    }
    
    // 편집모드로 들어가 테이블뷰 행을 삭제 가능하도록 하는 메서드
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // 테이블뷰가 편집모드일때 동작을 정의하는 메서드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let asset: PHAsset = self.fetchResult[indexPath.row]

            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.deleteAssets([asset] as NSArray)
            }, completionHandler: nil)
        }
    }
    
}


