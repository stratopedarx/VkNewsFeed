//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by Sergey Lobanov on 23.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    static let identifier = "FeedViewController"

    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        networkService.getFeed()
    }
}
