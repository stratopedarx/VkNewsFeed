//
//  ViewController.swift
//  VkNewsFeed
//
//  Created by Sergey Lobanov on 21.04.2022.
//

import UIKit

class AuthViewController: UIViewController {
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()

//        authService = AuthService()  // так работать не будет. надо что бы класс был один во всем приложении.
        authService = SceneDelegate.shared().authService
        view.backgroundColor = .red
    }

    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeAppSession()
    }
}
