//
//  NetworkService.swift
//  VkNewsFeed
//
//  Created by Sergey Lobanov on 24.04.2022.
//

import Foundation

final class NetworkService {
    private let authService: AuthService

    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }

    func getFeed() {
        guard let token = authService.token else { return }

        var allParams: [String: String] = [:]
        allParams["filters"] = Constants.ApiVKSdk.filtersQueryParams
        allParams["access_token"] = token
        allParams["v"] = Constants.ApiVKSdk.version

        var components = URLComponents()
        components.scheme = Constants.ApiVKSdk.scheme
        components.host = Constants.ApiVKSdk.host
        components.path = Constants.ApiVKSdk.newsFeedPath
        components.queryItems = allParams.map { URLQueryItem(name: $0, value: $1) }
        if let url = components.url {
            print("url: \(url)")
        }
    }
}
