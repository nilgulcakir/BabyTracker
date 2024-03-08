//
//  SceneDelegate.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 16.01.2024.
//

import UIKit
import RevenueCat

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        
        let onboardingCompleted = UserDefaults.standard.bool(forKey: "Value")
        let navigationController = UINavigationController()
        
        if onboardingCompleted {
            checkPremiumStatus { isPremium in
                DispatchQueue.main.async {
                    if isPremium {
                        self.window = UIWindow(windowScene: winScene)
                        self.window?.rootViewController = navigationController
                        navigationController.setViewControllers([HomeViewController()], animated: false)
                        self.window?.makeKeyAndVisible()
                    } else {
                        self.window = UIWindow(windowScene: winScene)
                        self.window?.rootViewController = navigationController
                        navigationController.setViewControllers([InAppVC()], animated: false)
                        self.window?.makeKeyAndVisible()
                    }
                }
            }
        } else {
            self.window = UIWindow(windowScene: winScene)
            self.window?.rootViewController = navigationController
            navigationController.setViewControllers([OnboardingOneVC()], animated: false)
            self.window?.makeKeyAndVisible()
        }
    }

    func checkPremiumStatus(completion: @escaping (Bool) -> Void) {
        Purchases.shared.getCustomerInfo { info, error in
            guard let info = info, error == nil else {
                completion(false)
                return
            }
            completion(info.entitlements.all["Monthly"]?.isActive == true)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
