//
//  AuthService.swift
//  VkNewsFeed
//
//  Created by Sergey Lobanov on 23.04.2022.
//

import Foundation
import VKSdkFramework

// делаем через ключевое слово class, что бы избежать утечек памяти и
// что бы этот протокол могли подписывать только под классы.
protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}

class AuthService: NSObject {
    static let identifier = "AuthViewController"
    // id нашего приложения
    private let appId = "8144980"
    private let vkSdk: VKSdk
    weak var delegate: AuthServiceDelegate?  // что бы использовать методы делегата, то через weak  добавляем.

    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }

    // проверяет авторизирован в приложении или нет
    func wakeAppSession() {
        let scope = Constants.ApiVKSdk.scope
        VKSdk.wakeUpSession(scope) { [delegate] state, _ in
            // [delegate] - создает некую копию делегата, таким образом утечки памяти точно не произойдет.
            switch state {
            case .initialized:
                // идет инициализация. Тут делаем авторизацию пользователя
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                // здесь происходит авторизация пользователя
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInDidFail()
            }
        }
    }
}

// MARK: - VKSdkDelegate, VKSdkUIDelegate

extension AuthService: VKSdkDelegate, VKSdkUIDelegate {
    // срабатывает в случае успешной авторизации. delegate - authServiceSignIn
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            print("token: \(result.token)")
            delegate?.authServiceSignIn()
        }
    }

    // срабатывает в случае ошибки. delegate - authServiceSignInDidFail
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFail()
    }

    // тут есть VK. Это от самих Vk - delegate authServiceShouldShow
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        // Надо открыть этот ВК c авторизацией и регистрацией пользователя. Это делаем через sceneDelegate.
        // Надо переделигировать логику. В момент срабатывания функции будем передвать ВьюКонтроллер в sceneDelegate.
        // И уже scene Delegate открывает этот вью контроллер. Создадим AuthServiceDelegate c 3 методами.
        delegate?.authServiceShouldShow(viewController: controller)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
