//
//  AuthService.swift
//  VkNewsFeed
//
//  Created by Sergey Lobanov on 23.04.2022.
//

import Foundation
import VKSdkFramework

class AuthService: NSObject {
    // id нашего приложения
    private let appId = "5115823"
    private let vkSdk: VKSdk

    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
}

extension AuthService: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }

    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
