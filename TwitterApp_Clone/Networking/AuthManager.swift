//
//  AuthManager.swift
//  TwitterApp_Clone
//
//  Created by 권정근 on 5/29/24.
//


// 앱 내 사용자 인증

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine



class AuthManager {
    
    static let shared = AuthManager()
    
    
    func registerUser(with email: String, password: String) -> AnyPublisher<User, Error> {
     
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func loginUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}





