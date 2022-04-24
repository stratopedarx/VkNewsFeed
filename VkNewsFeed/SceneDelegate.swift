//
//  SceneDelegate.swift
//  VkNewsFeed
//
//  Created by Sergey Lobanov on 21.04.2022.
//

import UIKit
import VKSdkFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var authService: AuthService!

    // сделаем Синглтоном, что бы была единственная точка входа. Тогда будет везде один authService
    static func shared() -> SceneDelegate {
        // сначала достаем сцену
        let scene = UIApplication.shared.connectedScenes.first
        let sceneDelegate: SceneDelegate = ((scene?.delegate as? SceneDelegate)!)
        return sceneDelegate
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure
        // and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new
        // (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // объявляем контроллер, с которого начнется приложение. Первоначальный экран авторизации AuthViewController.

        // 1. инициализируем window и передаем границы нашей сцены
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        // 2. Инициализируем наш Auth service
        authService = AuthService()
        // кто будет реализовывать все методы AuthServiceDelegate
        authService.delegate = self

        // 3. Добираемся до ВК auth
        let authVC = UIStoryboard(name: AuthService.identifier, bundle: nil)
            .instantiateInitialViewController() as? AuthViewController
        // 4. Назначаем рут ВК
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
    }

    // проверяем, что первая url, которую мы получаем, будет являться нашим нужным url
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded
        // (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

// MARK: - AuthServiceDelegate

extension SceneDelegate: AuthServiceDelegate {
    func authServiceShouldShow(viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }

    func authServiceSignIn() {
        print(#function)
        // после успешной авторизации хотим открывать новый ВК
        if let feedVC = UIStoryboard(name: FeedViewController.identifier, bundle: nil)
            .instantiateInitialViewController() as? FeedViewController {
            let navigationVC = UINavigationController(rootViewController: feedVC)  // добавим еще navigation vc
            window?.rootViewController = navigationVC
        }
    }

    func authServiceSignInDidFail() {
        print(#function)
    }

}
