//
//  SceneDelegate.swift
//  RichWallet
//
//  Created by Emir Alkal on 23.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
   
    app.router.start(windowScene)
  }
}
