//
//  MovieSynopsisTableViewCell.swift
//  BoxOffice
//
//  Created by uno on 2020/10/17.
//

import UIKit

class MovieSynopsisTableViewCell: UITableViewCell {
    
    // MARK:- Properties
    @IBOutlet weak var synopsisLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
