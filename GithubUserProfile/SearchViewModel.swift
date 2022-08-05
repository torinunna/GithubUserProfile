//
//  SearchViewModel.swift
//  GithubUserProfile
//
//  Created by 권유진 on 2022/08/05.
//

import Foundation
import Combine

final class SearchViewModel {
    
    let network: NetworkService
    init(network: NetworkService, selectedUser: UserProfile?) {
        self.network = network
        self.selectedUser = CurrentValueSubject(selectedUser)
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    let selectedUser: CurrentValueSubject<UserProfile?, Never>

    var name: String {
        return selectedUser.value?.name ?? "n/a"
    }
    var login: String {
        return selectedUser.value?.name ?? "n/a"
    }
    var followers: String {
        guard let value = selectedUser.value?.followers else { return "" }
        return "followers: \(value)"
    }
    var following: String {
        guard let value = selectedUser.value?.following else { return "" }
        return "following: \(value)"
    }
    var imageURL: URL? {
        return selectedUser.value?.avatarUrl
    }
    
    func search(keyword: String) {
        
        //        Resource
                let resource = Resource<UserProfile>(
                    base: "https://api.github.com/",
                    path: "users/\(keyword)",
                    params: [:],
                    header: ["Content-Type":"application/json"])
                
        //        NetworkService
                network.load(resource)
                    .receive(on: RunLoop.main)
                    .sink{ completion in
                        switch completion {
                        case .failure(let error):
                            self.selectedUser.send(nil)
                            print("error: \(error)")
                        case .finished: break
                        }
                    } receiveValue: { user in
                        self.selectedUser.send(user)
                    }.store(in: &subscriptions)
    }

}
