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
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch event {
                case .didFetchResults:
                    self?.tableView.reloadData()
                    break
                case .didFail(let message):
                    self?.showAlert(with: "Error!", message: message)
                    break
                case .scrollToTop:
                    let indexPath = IndexPath(row: 0, section: 0)
                    if let count = self?.tableView.visibleCells.count, count > 0 {
                        self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    break
                }
            }
        }
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search movies"
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.shouldPaginate(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text, text.count > 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            viewModel.searchMovies(with: text, isNewRequest: true)
        } else {
            showAlert(with: "Please enter text to search", message: nil)
        }
    }

}
