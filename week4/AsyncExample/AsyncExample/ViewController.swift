//
//  ViewController.swift
//  AsyncExample
//
//  Created by uno on 2020/09/27.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!

    // MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadButton.addTarget(self, action: #selector(touchUpDownloadButton), for: .touchUpInside)
    }
    
    // MARK:- Methods
    @objc func touchUpDownloadButton() {
        // https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg
        guard let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg") else { return }
        
        OperationQueue().addOperation {
            guard let imageData = try? Data.init(contentsOf: imageURL), let image = UIImage(data:imageData) else {return}
            
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
    }

}

