//
//  DataManager.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/28.
//

import Foundation
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser

class DataManager {
    let baseUrl = "https://challenge-api.gridge.co.kr"
    //MARK: - 자체 로그인
    func postUserSignIn(id: String, password: String, completion: @escaping (UserPostResponse) -> Void) {
        let parameters: Parameters = [
            "loginId": "\(id)",
            "password": "\(password)"
          ]
        AF.request(
            baseUrl + "/app/sign-in",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default)
        .responseDecodable(of: UserPostResponse.self) { result in
            
            switch result.result {
            case .success(let success):
                completion(success)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - 자동 로그인
    func getUserAutoSignIn(completion: @escaping (UserPostResponse) -> Void) {
        guard let jwt = UserDefaults.standard.string(forKey: "jwt") else {return}
        let headers: HTTPHeaders = [
            "x-access-token": jwt]
        AF.request(
            baseUrl + "/app/auto-sign-in",
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: headers)
        .responseDecodable(of: UserPostResponse.self) { result in

            switch result.result {
            case .success(let success):
                completion(success)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - 카카오 로그인
    func postUserKakaoSignIn(accessToken: String, completion: @escaping (UserPostResponse) -> Void) {
        print(accessToken)
        let parameter : Parameters = [
            "accessToken": "\(accessToken)"
        ]
        AF.request(
            baseUrl + "/app/kakao-sign-in",
            method: .post,
            parameters: parameter,
            encoding: JSONEncoding.default)
        .responseDecodable(of: UserPostResponse.self) { result in

            switch result.result {
            case .success(let success):
                completion(success)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
