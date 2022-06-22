//
//  AppCoordinator.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import Foundation
import UIKit
protocol AppCoordinatorProtocol {
    var navigatorController: UINavigationController {get set}
    func Start()
}

final class AppCoordinator:AppCoordinatorProtocol {
    var navigatorController:UINavigationController
    var tabBarCoordinator: TabCoordinator?

    
    func Start() {
        let tabBarCoordinator = TabCoordinator(navigationController: self.navigatorController)
        self.tabBarCoordinator = tabBarCoordinator
        self.tabBarCoordinator?.Start()
    }
    
    init(navigationController: UINavigationController) {
        self.navigatorController = navigationController
    }
}

