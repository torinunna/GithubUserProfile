//
//  UserProfilewViewController.swift
//  GithubUserProfile
//
//  Created by YUJIN KWON on 2023/05/31.
//

import UIKit
import Combine
import Kingfisher

class UserProfilewViewController: UIViewController {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    var viewModel: UserProfileViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserProfileViewModel(network: NetworkService(configuration: .default), selectedUser: nil)
        setupUI()
        embedSearchControl()
        bind()
    }

    private func setupUI() {
        thumbnail.layer.cornerRadius = 80
    }
    
    private func embedSearchControl() {
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "torinunna"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func bind() {
        viewModel.selectedUser
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.nameLabel.text = self.viewModel.name
                self.loginLabel.text = self.viewModel.login
                self.followerLabel.text = self.viewModel.followers
                self.followingLabel.text = self.viewModel.following
                self.thumbnail.kf.setImage(with: self.viewModel.avatarUrl)
            }.store(in: &subscriptions)
    }
}

extension UserProfilewViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        print("search: \(keyword)")
    }
}

extension UserProfilewViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        viewModel.search(keyword: keyword)
    }
}
