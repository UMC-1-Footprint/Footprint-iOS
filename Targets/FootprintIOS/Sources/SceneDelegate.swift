//
//  SceneDelegate.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/08/22.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIViewController()
       
        window?.makeKeyAndVisible()
    }
}
