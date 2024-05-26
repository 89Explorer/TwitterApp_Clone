//
//  ProfileViewController.swift
//  TwitterApp_Clone
//
//  Created by 권정근 on 5/25/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var isStausBarHidden: Bool = true
    
    // 상태표시줄 설정
    private let statusBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.opacity = 0
        return view
    }()
    
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
        view.addSubview(statusBar)
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        profileTableView.contentInsetAdjustmentBehavior = .never
        
        // 네비게이션 부분 숨기기 -> HomeView에는 네비게이션 부분이 있다가 -> 프로필에 가면 없어졌다가 -> 다시 돌아오면 HomeView에도 없어져있다. 
        navigationController?.navigationBar.isHidden = true
        
        
        
        configureConstraints()
        
        
        let headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 380))
        profileTableView.tableHeaderView = headerView
    }
    
    
    private func configureConstraints() {
        
        let profileTableViewConstraints = [
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let statusBarConstraints = [
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: view.bounds.height > 800 ? 40 : 20)
        ]
        
        NSLayoutConstraint.activate(profileTableViewConstraints)
        NSLayoutConstraint.activate(statusBarConstraints)
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
    
    
    // 스크롤할 때 상태창 설정 함수
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        
        if yPosition > 150 && isStausBarHidden {
            isStausBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 1
            } completion: { _ in }
        } else if yPosition < 0 && !isStausBarHidden {
            isStausBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 0
            } completion: { _ in }
        }
    }
}
