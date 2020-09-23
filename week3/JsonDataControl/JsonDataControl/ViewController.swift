//
//  ViewController.swift
//  JsonDataControl
//
//  Created by uno on 2020/09/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    var friends: [Friend] = []
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        let nibName = UINib(nibName: "FriendTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: cellIdentifier)
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "friends") else {
            return
        }
        
        do {
            self.friends = try jsonDecoder.decode([Friend].self, from: dataAsset.data)
        } catch {
            print(error)
        }
        
//        self.tableView.reloadData()
    }
    
    // MARK:- Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let friend: Friend = self.friends[indexPath.row]
        
        cell.textLabel?.text = friend.nameAndAge
        cell.detailTextLabel?.text = friend.fullAddress
        
        return cell
    }

}

