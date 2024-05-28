//
//  HomeViewController.swift
//  TwitterApp_Clone
//
//  Created by 권정근 on 5/24/24.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    
    private func configureNavigationBar() {
        let size: CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "logo")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView
        
        
        
        
        // profile
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile))
    }
    
    @objc private func didTapProfile() {
        print("didTapProfile() - called")
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
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
        
        configureNavigationBar()
        
        
        // firebase 로그인 여부에 따른 온보딩화면 표시
        if Auth.auth().currentUser == nil {
            
            let onboardingVC = UINavigationController(rootViewController: OnboardingViewController())
            // let onboardingVC = OnboardingViewController()
            onboardingVC.modalPresentationStyle = .fullScreen

            // present(onboardingVC, animated: true)
            present(onboardingVC, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        timelineTableView.frame = view.bounds
    
    }
    
    // 프로필뷰에서 네비게이션 숨기기에 따라 홈 -> 프로필 -> 홈으로 돌아오는 과정에서 홈에도 네비게이션이 숨기기로 나오는 것을 고침
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        
        // firebase 로그인 여부에 따른 온보딩화면 표시
        if Auth.auth().currentUser == nil {
            
            // let onboardingVC = UINavigationController(rootViewController: OnboardingViewController())
            let onboardingVC = OnboardingViewController()
            onboardingVC.modalPresentationStyle = .fullScreen

            // present(onboardingVC, animated: true)
            navigationController?.pushViewController(onboardingVC, animated: true)
        }
        

    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, 
                                                       for: indexPath) as? TweetTableViewCell  
        else {
            return UITableViewCell()
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
