//
//  DetailViewController.swift
//  CountryApp
//
//  Created by Akash Katoch on 15/01/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var countryData = [CountryModel]()
    var searchData = [CountryModel]()

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiHandler.shared.getDataUsingAlamofire { data in
            self.countryData.append(contentsOf: data)
            self.searchData.append(contentsOf: data)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.activityIndicator.stopAnimating()
        }
        self.activityIndicator.startAnimating()
        self.setupSearchController()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupSearchController(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension DetailViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
       config.text = searchData[indexPath.row].name
        cell.contentConfiguration = config
        return cell
    }
}

extension DetailViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
       guard let searchString = searchController.searchBar.text else { return }
        
        if searchString.isEmpty{
            searchData = countryData
        }else{
            searchData = countryData.filter({
                $0.name.lowercased().contains(searchString.lowercased())
            })
        }
        self.tableView.reloadData()
    }
}
