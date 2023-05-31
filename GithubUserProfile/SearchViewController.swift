//
//  SearchViewController.swift
//  GithubUserProfile
//
//  Created by YUJIN KWON on 2023/05/31.
//

import UIKit
import Combine

class SearchViewController: UIViewController {

    @Published private(set) var user: UserProfile?
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }

    private func setupUI() {
        thumbnail.layer.cornerRadius = 80
    }
    
    private func bind() {
        $user
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.update(user)
            }.store(in: &subscriptions)
    }

    private func update(_ user: UserProfile?) {
        
    }

}

