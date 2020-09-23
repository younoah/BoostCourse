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

extension CityViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: CityTableViewCell.self),
                for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        cell.cityNameLabel.text = citiesArray[indexPath.row].cityName
        
        return cell
    }
    
}

extension CityViewController : UITableViewDelegate {
    
}

