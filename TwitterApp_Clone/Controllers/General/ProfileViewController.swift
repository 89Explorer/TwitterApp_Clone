//
//  ProfileViewController.swift
//  TwitterApp_Clone
//
//  Created by 권정근 on 5/25/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    private let profileTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
        
        view.addSubview(profileTableView)
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        configureConstraints()
        
        
        let headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 350))
        profileTableView.tableHeaderView = headerView
    }
    
    
    private func configureConstraints() {
        
        let profileTableViewConstraints = [
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(profileTableViewConstraints)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else { return TweetTableViewCell() }
        
        return cell
    }
}
