//
//  DetailViewController.swift
//  WeatherToday
//
//  Created by uno on 2020/09/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    var city: City?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let city = city {
            navigationItem.title = city.cityName
            
            imageView.image = UIImage(named: city.getWeatherString)
            stateLabel.text = city.getWeatherKoreanString
            temperatureLabel.text = city.temperatureString
            rainfallLabel.text = city.rainfallProbabilityString
            
            if city.celsius < 10 {
                temperatureLabel.textColor = UIColor.systemBlue
            }
            if city.rainfallProbability > 50 {
                rainfallLabel.textColor = UIColor.systemOrange
            }
        }
    }

}
