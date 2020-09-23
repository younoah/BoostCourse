//
//  CityTableViewCell.swift
//  WeatherToday
//
//  Created by uno on 2020/09/23.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
