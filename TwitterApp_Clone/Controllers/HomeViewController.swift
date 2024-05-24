//
//  HomeViewController.swift
//  TwitterApp_Clone
//
//  Created by 권정근 on 5/24/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    private let timelineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(timelineTableView)
        
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        timelineTableView.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell  else { return UITableViewCell()
        }
        
        // 델리게이트 패턴에 대한 대리자를 HomeViewController 설정
        cell.delegate = self
        
        return cell
    }
    
}

extension HomeViewController: TweetTableViewCellDelegate {
    func tweetTableViewCellDidTapReply() {
        print("tweetTableViewCellDidTapReply() - called")
    }
    
    func tweetTableViewCellDidTapRetweet() {
        print("tweetTableViewCellDidTapRetweet() - called")
    }
    
    func tweetTableViewCellDidTapLike() {
        print("tweetTableViewCellDidTapLike() - called")
    }
    
    func tweetTableViewCellDidTapShare() {
        print("tweetTableViewCellDidTapShare() - called")
    }
    
    
}
