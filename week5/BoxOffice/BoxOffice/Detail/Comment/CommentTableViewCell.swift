//
//  CommentTableViewCell.swift
//  BoxOffice
//
//  Created by uno on 2020/10/17.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    // MARK:- Properties
    @IBOutlet weak var writerNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
