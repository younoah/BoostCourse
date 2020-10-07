//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by uno on 2020/10/06.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK:- properties
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieGradeImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieInfoLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
