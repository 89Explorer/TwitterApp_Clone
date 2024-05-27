//
//  ProfileHeader.swift
//  TwitterApp_Clone
//
//  Created by 권정근 on 5/25/24.
//

import UIKit

class ProfileTableViewHeader: UIView {
    
    
    private enum SectionTabs: String {
        
        case tweets = "Tweets"
        case tweetAndReplies = "Tweets & Replies"
        case media = "Media"
        case likes = "Likes"
        
        var index: Int {
            switch self {
            case .tweets:
                return 0
            case .tweetAndReplies:
                return 1
            case .media:
                return 2
            case .likes:
                return 3
            }
        }
    }
    
    // indicatore 관련 제약조건 설정
    private var leadingAnchors: [NSLayoutConstraint] = []
    private var trailingAnchors: [NSLayoutConstraint] = []
    
    // 각 카테코리 버튼 아래 지시선
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    
    private var selectedTab: Int = 0 {
        didSet {
            for i in 0..<tabs.count {
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) { [weak self] in
                    self?.sectionStack.arrangedSubviews[i].tintColor = i == self?.selectedTab ? .label : .secondaryLabel
                    self?.leadingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.trailingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.layoutIfNeeded()
                } completion: { _ in }
            }
        }
    }
    
    
    private var tabs: [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"]
        .map { buttonTitle in
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.tintColor = .label
            button.setTitle(buttonTitle, for: .normal)
            return button
        }
    
    
    private lazy var sectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    
    private let followersTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Followers"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1M"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let followingTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Following"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let followingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "314"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    
    private let joinDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Joined May 2024"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let joinDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    
    private let userBioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .label
        label.text = "iOS Developer"
        return label
    }()
        
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@Explorer"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Explorer"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    
    private let profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "profile")
        imageView.backgroundColor = .systemYellow
        return imageView
    }()
    
    private let profileHeaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "header")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // backgroundColor = .systemBlue
        
        addSubview(profileHeaderImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(userNameLabel)
        addSubview(userBioLabel)
        addSubview(joinDateImageView)
        addSubview(joinDateLabel)
        
        addSubview(followingCountLabel)
        addSubview(followingTextLabel)
        addSubview(followersCountLabel)
        addSubview(followersTextLabel)
        
        addSubview(sectionStack)
        
        addSubview(indicator)
        
        
        configureConstraints()
        configureStackButton()
    }
    
    private func configureStackButton() {
        for (i, button) in sectionStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            
            
            // 처음 화면이 로드 되었을 때 보여주기 위함
            if i == selectedTab {
                button.tintColor = .label
            } else {
                button.tintColor = .secondaryLabel
            }
            
            button.addTarget(self, action: #selector(didTapTab(_: )), for: .touchUpInside)
        }
    }
    
    
    @objc private func didTapTab(_ sender: UIButton) {
        guard let label = sender.titleLabel?.text else { return }
        
        switch label {
        case SectionTabs.tweets.rawValue:
            selectedTab = 0
        case SectionTabs.tweetAndReplies.rawValue:
            selectedTab = 1
        case SectionTabs.media.rawValue:
            selectedTab = 2
        case SectionTabs.likes.rawValue:
            selectedTab = 3
            
        default:
            selectedTab = 0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        for i in 0..<tabs.count {
            let leadingAnchor = indicator.leadingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].leadingAnchor)
            leadingAnchors.append(leadingAnchor)
            let trailingAnchor = indicator.trailingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].trailingAnchor)
            trailingAnchors.append(trailingAnchor)
        }
        
        
        let profileHeaderImageViewConstraints = [
            profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        
        let profileAvatarImageViewConstraints = [
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor, constant: 10),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let displayNameLabelConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 20)
        ]
        
        let userNameLabelConstraints = [
            userNameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userNameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5)
        ]
        
        let userBioLabelConstraints = [
            userBioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            userBioLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5)
        ]
        
        let joinDateImageViewConstraints = [
            joinDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            joinDateImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 5)
        ]
        
        let joinDateLabelConstraints = [
            joinDateLabel.leadingAnchor.constraint(equalTo: joinDateImageView.trailingAnchor, constant: 2),
            joinDateLabel.bottomAnchor.constraint(equalTo: joinDateImageView.bottomAnchor)
        ]
        
        let followingCountLabelConstraint = [
            followingCountLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            followingCountLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor, constant: 10)
        ]
        
        let followingTextLabelConstraint = [
            followingTextLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant: 4),
            followingTextLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor)
        ]
        
        let followersCountLabelConstraints = [
            followersCountLabel.leadingAnchor.constraint(equalTo: followingTextLabel.trailingAnchor, constant: 8),
            followersCountLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor)
        ]
        
        let followersTextLabelConstraints = [
            followersTextLabel.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor, constant: 4),
            followersTextLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor)
        ]
        
        let sectionStackConstraints = [
            sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            sectionStack.topAnchor.constraint(equalTo: followingCountLabel.bottomAnchor, constant: 3),
            sectionStack.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let indicatorConstraints = [
            leadingAnchors[0],
            trailingAnchors[0],
            indicator.topAnchor.constraint(equalTo: sectionStack.arrangedSubviews[0].bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ]
        
        NSLayoutConstraint.activate(profileHeaderImageViewConstraints)
        NSLayoutConstraint.activate(profileAvatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(userNameLabelConstraints)
        NSLayoutConstraint.activate(userBioLabelConstraints)
        NSLayoutConstraint.activate(joinDateImageViewConstraints)
        NSLayoutConstraint.activate(joinDateLabelConstraints)
        
        NSLayoutConstraint.activate(followingCountLabelConstraint)
        NSLayoutConstraint.activate(followingTextLabelConstraint)
        
        NSLayoutConstraint.activate(followersCountLabelConstraints)
        NSLayoutConstraint.activate(followersTextLabelConstraints)
        
        NSLayoutConstraint.activate(sectionStackConstraints)
        
        NSLayoutConstraint.activate(indicatorConstraints)
    }
}
