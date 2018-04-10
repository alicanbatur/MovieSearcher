//
//  HomeViewController.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import UIKit

// This VC is responsible for only the view operations.
// HomeTableViewModel is responsible for data operations.
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

    // MARK: - Private Helpers
    
    // Subscribe to viewModel for events.
    // Ofc I can use delegation for this, but I just wanted to use another pattern here.
    // Totally my decision.
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
                    self?.searchBar.text = self?.viewModel.lastSearchedQuery
                    break
                case .didUpdateDataType:
                    self?.tableView.reloadData()
                    break
                }
            }
        }
    }
    
    // Adds searchBar into navigaitonItem
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search movies"
        navigationItem.titleView = searchBar
    }
    
    // A helper func to show alerts.
    private func showAlert(with title: String?, message: String?) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .default, handler: nil)
        controller.addAction(doneAction)
        present(controller, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isSuggestionDataType {
            let cell: SuggestionCell = tableView.dequeueReusableCell(withIdentifier: SuggestionCell.reuseIdentifier(), for: indexPath) as! SuggestionCell
            cell.viewModel = viewModel.suggestionCellViewModel(at: indexPath)
            return cell
        } else {
            let cell: MovieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier(), for: indexPath) as! MovieCell
            cell.viewModel = viewModel.movieCellViewModel(at: indexPath)
            return cell
        }
    }
    
    // Calls next page if needed.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.shouldPaginate(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        viewModel.searchSuggestion(at: indexPath)
    }
    
}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    // Toggle to suggestion when this fired.
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.toggleTableViewData(isSuggestion: true)
        searchBar.showsCancelButton = true
    }
    
    // Toggle to movies when this fired.
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.toggleTableViewData(isSuggestion: false)
    }
    
    // When search (returnKey) clicked, check for text, if not nil then make search call.
    // If it is nil, warn user.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        if let text = searchBar.text, text.count > 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            viewModel.searchMovies(with: text, isNewRequest: true)
        } else {
            showAlert(with: "Please enter text to search", message: nil)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.toggleTableViewData(isSuggestion: false)
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }

}
