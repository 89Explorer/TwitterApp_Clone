//
//  SearchViewViewModel.swift
//  TwitterApp_Clone
//
//  Created by 권정근 on 6/14/24.
//

import Foundation
import Combine

class SearchViewViewModel {

    var subscriptions: Set<AnyCancellable> = []

    func search(with query: String, _ completion: @escaping ([TwitterUser]) -> Void) {
        DatabaseManager.shared.collectionUsers(search: query)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { users in
                completion(users)
            }
            .store(in: &subscriptions)
    }
}
