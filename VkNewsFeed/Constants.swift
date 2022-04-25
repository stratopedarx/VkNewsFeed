//
//  Constants.swift
//  VkNewsFeed
//
//  Created by Sergey Lobanov on 24.04.2022.
//

enum Constants {
    enum ApiVKSdk {
        static let scope = ["offline"]
        static let scheme = "https"
        static let host = "api.vk.com"
        static let version = "5.131"
        static let newsFeedPath = "/method/newsfeed.get"
        static let filtersQueryParams = "post,photo"
    }
}
