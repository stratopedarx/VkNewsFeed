//
//  AppDelegate.swift
//  VkNewsFeed
//
//  Created by Sergey Lobanov on 21.04.2022.
//

import UIKit
import VKSdkFramework

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // вызываем эту функцию для того, что бы она могла открывать url. Будем явно указывать какую ссылку мы хотим
    // открывать и на какую ссылку сафари будет сразу перенаправлять, когда хотим авторизоваться или зарег-я через вк.
    // Данная функция просит AppDelegate открывать ресурс, указанный по url и предоставит нам словарь опций запуска,
    // что бы мы открыли нужную страницу. Еще часть логики будет настраиваться в SceneDelegate.
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // OpenURLOptionsKey - здесь хранятся ключи, используемые для доступа к значениям в словаре паратметров
        // при открытии URL. sourceApplication - содержит идентификатор пакета приложений.
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running,
        // this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
