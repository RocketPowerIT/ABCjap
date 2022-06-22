//
//  TabCoordinator.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import Foundation
import UIKit

class TabCoordinator: AppCoordinatorProtocol {
    var navigatorController: UINavigationController
    
    var tabBarController = UITabBarController()
    var tabBarControllers = [UIViewController]()
    
    let mainCoordinator:CoordinatorTabABC?
    let favCoordinator:ChildCoordinatorQuiz?
    
    init(navigationController: UINavigationController) {
        self.navigatorController = navigationController
        mainCoordinator = CoordinatorTabABC(navigationController: navigatorController)
        favCoordinator = ChildCoordinatorQuiz(navigationController: navigatorController)
    }
    
    func Start() {
        self.mainCoordinator?.initVC()
        self.mainCoordinator?.vc.tabBarItem = UITabBarItem(title: "ABC", image: nil, selectedImage: nil)

        self.favCoordinator?.initVC()
        self.favCoordinator?.secondVC.tabBarItem = UITabBarItem(title: "QUIZZ", image: nil, selectedImage: nil)
        
        tabBarController.viewControllers = [self.mainCoordinator!.vc,self.favCoordinator!.secondVC]
        navigatorController.pushViewController(tabBarController, animated: false)
    }
}
