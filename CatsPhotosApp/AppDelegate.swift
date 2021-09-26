//
//  AppDelegate.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 25.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		let tabBarController = UITabBarController()
		tabBarController.setViewControllers(getArrayOfViewControllers(), animated: true)
		tabBarController.modalPresentationStyle = .fullScreen
		guard let items = tabBarController.tabBar.items else {
			return false
		}
		let arrayOfTabBarImagesNames: [String] = ["magnifyingglass", "plus.circle", "heart"]
		for itemIndex in 0..<items.count {
			items[itemIndex].image = UIImage(systemName: arrayOfTabBarImagesNames[itemIndex])
			items[itemIndex].title = tabBarController.viewControllers?[itemIndex].title
		}
		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()
		return true
	}
	func getArrayOfViewControllers() -> [UIViewController] {
		var arrayOfViewControllers: [UIViewController] = []
		let searchViewController = UINavigationController(rootViewController: SearchViewController())
		let uploadViewController = UINavigationController(rootViewController: UploadViewController())
		let favoriteViewController = UINavigationController(rootViewController: FavoriteViewController())
		searchViewController.title = "Search"
		uploadViewController.title = "Upload"
		favoriteViewController.title = "Favorites"
		arrayOfViewControllers.append(searchViewController)
		arrayOfViewControllers.append(uploadViewController)
		arrayOfViewControllers.append(favoriteViewController)
		return arrayOfViewControllers
	}
}
