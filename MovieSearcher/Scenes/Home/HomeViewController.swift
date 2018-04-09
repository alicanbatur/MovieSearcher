//
//  HomeViewController.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar = UISearchBar()
    var viewModel: HomeTableViewModel = HomeTableViewModel()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        configureSearchBar()
        subscribeToTableViewModel()
    }

    private func subscribeToTableViewModel() {
        viewModel.on { [weak self] (event) in
            switch event {
            case .didFetchResults:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                break
            }
        }
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func showAlert(with title: String?, message: String?) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .default, handler: nil)
        controller.addAction(doneAction)
        present(controller, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier(), for: indexPath) as! MovieCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text, text.count > 0 {
            viewModel.searchMovies(with: text)
        } else {
            showAlert(with: "Please enter text to search", message: nil)
        }
    }

}
