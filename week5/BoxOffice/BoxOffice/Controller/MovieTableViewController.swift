//
//  ViewController.swift
//  BoxOffice
//
//  Created by uno on 2020/10/06.
//

import UIKit

class MovieTableViewController: UIViewController {
    
    // MARK:- properties
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "movieCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.title = "리스트"
        
        let nibName = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: cellIdentifier)
        
    }

}

extension MovieTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cellIdentifier,
                for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}

extension MovieTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieDetailViewController = self.storyboard?.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
}
