//
//  SceneDelegate.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  var coordinator: Coordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.windowScene = windowScene
    let navigationController = UINavigationController()
    coordinator = DashboardCoordinator(navigation: navigationController)
    coordinator?.start()
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    guard let _ = (scene as? UIWindowScene) else { return }
  }


}

