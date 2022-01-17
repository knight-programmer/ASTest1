//
//  ViewController.swift
//  CountryApp
//
//  Created by Akash Katoch on 15/01/22.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }

    func configuration(){
        self.tableView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        //ApiHandler.shared.postDataUsingAlamofire()
//        ApiHandler.shared.getDataUsingAlamofire { data in
//            self.articles.append(contentsOf: data)
//            self.tableView.reloadData()
//        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
//    func setupSearchController(){
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.placeholder = "Search"
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchResultsUpdater = self
//        definesPresentationContext = true
//        self.navigationItem.searchController = searchController
//    }

}

 // MARK: - Data Source
extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsViewCell else { return UITableViewCell() }
        cell.cellConfiguration(article: articles[indexPath.row])
        return cell
    }
}

// MARK: - Delegate
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: articles[indexPath.row].url){
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url , configuration: config)
            self.present(vc, animated: true)
        }
    }
}
