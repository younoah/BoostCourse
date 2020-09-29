//
//  ImageZoomViewController.swift
//  PhotosExample
//
//  Created by uno on 2020/09/29.
//

import UIKit
import Photos

class ImageZoomViewController: UIViewController {
    
    // MARK:- properties
    // 전 화면에서 받아올 에셋 프로퍼티
    var asset: PHAsset!
    let imageManager = PHCachingImageManager()
    @IBOutlet weak var imageView: UIImageView!

    // MARK:- view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageManager.requestImage(
            for: asset,
            targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight),
            contentMode: .aspectFill,
            options: nil,
            resultHandler: { image, _ in self.imageView.image = image})
    }

}

// MARK:- ScrollViewDelegate
extension ImageZoomViewController: UIScrollViewDelegate {
    
    // 스크롤뷰가 주밍을 한 대상을 지정
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
