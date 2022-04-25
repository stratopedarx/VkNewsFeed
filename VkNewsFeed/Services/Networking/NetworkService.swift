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

    private func createDataTask(from request: URLRequest,
                                completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }

    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()

        components.scheme = Constants.ApiVKSdk.scheme
        components.host = Constants.ApiVKSdk.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        if let url = components.url {
            print("url: \(url)")
            return url
        }
        return URL(string: "www.google.com")!
    }
}

extension NetworkService: NetworkingProtocol {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }

        var allParams: [String: String] = params
        allParams["access_token"] = token
        allParams["v"] = Constants.ApiVKSdk.version
        let url = self.url(from: path, params: allParams)

        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
}
