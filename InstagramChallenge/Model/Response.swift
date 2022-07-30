//
//  File.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/28.
//

import Foundation

// MARK: - UserPostResponse
struct UserPostResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
}

// MARK: - Result
struct Result: Codable {
    let jwt: String
}

