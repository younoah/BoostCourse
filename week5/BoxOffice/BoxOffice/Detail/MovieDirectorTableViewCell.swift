//
//  MovieDirectorTableViewCell.swift
//  BoxOffice
//
//  Created by uno on 2020/10/17.
//

import UIKit

class MovieDirectorTableViewCell: UITableViewCell {
    
    // MARK:- Properties
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
