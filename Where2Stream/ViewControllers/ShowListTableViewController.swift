//
//  ShowListTableViewController.swift
//  Where2Stream
//
//  Created by Landon Epps on 10/2/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class ShowListTableViewController: UITableViewController {
    
    let showsController = ShowsController()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.isActive = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsController.shows?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowTableViewCell
            else { return UITableViewCell() }

        if let show = showsController.shows?[indexPath.row] {
            cell.updateView(with: show)
        }

        return cell
    }
}

extension ShowListTableViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty
            else { return }
        
        showsController.getShowsMatching(searchTerm: searchText) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                searchBar.resignFirstResponder()
            }
        }
    }
}
