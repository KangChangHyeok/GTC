//
//  File.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/08/04.
//

import Foundation

class UserSignUpInfo {
    static let shared = UserSignUpInfo()
    var userName: String = ""
    var userPhoneNumber: String = ""
    var userPassWord: String = ""
    var userBirthday: String = ""
    var userNickName: String = ""
    var loginPattern: pattern = .normal
    var accessToken: String = ""
    private init() {}
}


enum pattern {
    case normal
    case kakao
}
