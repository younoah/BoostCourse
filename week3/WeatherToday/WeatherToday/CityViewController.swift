//
//  CityViewController.swift
//  WeatherToday
//
//  Created by uno on 2020/09/23.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cityCell"
    var country: Country?
    var citiesArray: [City] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 100;
        
        navigationItem.title = country?.koreanName
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: cellIdentifier)
        
        let jsonDecoder = JSONDecoder()
        guard let country = country, let dataAsset = NSDataAsset(name: country.assetName) else {
            return
        }
        do {
            citiesArray = try jsonDecoder.decode([City].self, from: dataAsset.data)
        } catch {
            print(error)
        }
    }
    
}

// MARK:- Table View DataSource
extension CityViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CityTableViewCell = tableView.dequeueReusableCell(
                withIdentifier: cellIdentifier,
                for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        cell.cityImageView.image = UIImage(named: "\(citiesArray[indexPath.row].getWeatherString)")
        cell.cityNameLabel.text = citiesArray[indexPath.row].cityName
        cell.temperatureLabel.text = citiesArray[indexPath.row].temperatureString
        cell.rainfallLabel.text = citiesArray[indexPath.row].rainfallProbabilityString
        cell.accessoryType = .disclosureIndicator
        
        if citiesArray[indexPath.row].celsius < 10 {
            cell.temperatureLabel.textColor = UIColor.systemBlue
        } else {
            cell.temperatureLabel.textColor = UIColor.black
        }
        
        if citiesArray[indexPath.row].rainfallProbability > 50 {
            cell.rainfallLabel.textColor = UIColor.systemOrange
        } else {
            cell.rainfallLabel.textColor = UIColor.black
        }
        
        
        return cell
    }
    
}

// MARK:- Table View Delegate & DataSource
extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        detailViewController.city = citiesArray[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}


