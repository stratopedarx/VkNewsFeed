//
//  NetworkingProtocol.swift
//  VkNewsFeed
//
//  Created by Sergey Lobanov on 25.04.2022.
//

import Foundation

protocol NetworkingProtocol {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}
