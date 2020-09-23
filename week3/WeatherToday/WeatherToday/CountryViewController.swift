//
//  ViewController.swift
//  WeatherToday
//
//  Created by uno on 2020/09/23.
//

import UIKit

class CountryViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "countryCell"
    
    var countriesArray: [Country] = []

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "세계 날씨"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "CountryTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: cellIdentifier)
        
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "countries") else {
            return
        }
        do {
            countriesArray = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            print(error)
        }
    }
    
    // MARK:- Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

// MARK:- Table View Delegate & DataSource
extension CountryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.imageView?.image = UIImage(named: countriesArray[indexPath.row].flagName)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = countriesArray[indexPath.row].koreanName
        
        return cell
    }
    
}

// MARK:- Table View Delegate & DataSource
extension CountryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cityViewController = self.storyboard?.instantiateViewController(identifier: "CityViewController") as? CityViewController else {
            return
        }
        cityViewController.country = countriesArray[indexPath.row]
        navigationController?.pushViewController(cityViewController, animated: true)
    }
    
}

