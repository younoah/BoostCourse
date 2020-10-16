//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by uno on 2020/10/06.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    var movie: MovieDetail?
    
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.title = "영화제목"
        
        tableView.register(
            UINib(nibName: "MovieDetailInfomationTableViewCell", bundle: nil),
            forCellReuseIdentifier: "movieDetailInformationCell"
        )
        tableView.register(
            UINib(nibName: "MovieSynopsisTableViewCell", bundle: nil),
            forCellReuseIdentifier: "movieSynopsisCell"
        )
        tableView.register(
            UINib(nibName: "MovieDirectorTableViewCell", bundle: nil),
            forCellReuseIdentifier: "movieDirectorCell"
        )
        tableView.register(
            UINib(nibName: "CommentTableViewCell", bundle: nil),
            forCellReuseIdentifier: "commentCell"
        )
        tableView.register(
            UINib(nibName: "CommentSectionHeader", bundle: nil),
            forCellReuseIdentifier: "commentHeader"
        )

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK:- Table View DataSource
extension MovieDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

// MARK:- Table View Delegate
extension MovieDetailViewController: UITableViewDelegate {
    
}
