//
//  HomeViewController.swift
//  TwitterApp_Clone
//
//  Created by 권정근 on 5/24/24.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {
    
    private var viewModel = HomeViewViewModel()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    private lazy var composeTweetButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction { _ in
            self.navigationToTweetCompose()
        })
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemMint
        button.tintColor = .label
        
        let plussign = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold))
        button.setImage(plussign, for: .normal)
        
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        return button
        
    }()
    
    
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
        
        let viewModel = ProfileViewViewModel()
        let profileVC = ProfileViewController(viewModel: viewModel)
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func navigationToTweetCompose() {
        
        let TweetComposeVC = UINavigationController(rootViewController: TweetComposeViewController())
        TweetComposeVC.modalPresentationStyle = .fullScreen
        present(TweetComposeVC, animated: true)
    }
    
    
    private let timelineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(timelineTableView)
        view.addSubview(composeTweetButton)
        
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        
        configureNavigationBar()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSignOut))
        
        bindViews()
        
        configureConstraints()
        
        
    }
    
    @objc private func didTapSignOut() {
        try? Auth.auth().signOut()
        handleAuthentication()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        timelineTableView.frame = view.bounds
    
    }
    
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let onboardingVC = UINavigationController(rootViewController: OnboardingViewController())
            // onboardingVC.modalPresentationStyle = .fullScreen
            present(onboardingVC, animated: true)
        }
    }
    
    // 프로필뷰에서 네비게이션 숨기기에 따라 홈 -> 프로필 -> 홈으로 돌아오는 과정에서 홈에도 네비게이션이 숨기기로 나오는 것을 고침
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        // 로그인 여부 확인
        handleAuthentication()
        
        viewModel.retreiveUser()
    }
    
    func completeUserOnboarding() {
        let profileDataFormVC = ProfileDataFormViewController()
        present(profileDataFormVC, animated: true)
    }
    
    func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            if !user.isUserOnboarded {
                self?.completeUserOnboarding()
            }
        }
        .store(in: &subscriptions)
        
        viewModel.$tweets.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.timelineTableView.reloadData()
            }
        }
        .store(in: &subscriptions)
    }
    
    
    
    private func configureConstraints() {
        
        let composeTweetButtonConstraints = [
            composeTweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            composeTweetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            composeTweetButton.widthAnchor.constraint(equalToConstant: 60),
            composeTweetButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(composeTweetButtonConstraints)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, 
                                                       for: indexPath) as? TweetTableViewCell  
        else {
            return UITableViewCell()
        }
        
        let tweetModel = viewModel.tweets[indexPath.row]
        cell.configureTweet(with: tweetModel.author.displayName, username: tweetModel.author.username, tweetTextContent: tweetModel.tweetContent, avatarPath: tweetModel.author.avatarPath)
        
    
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
