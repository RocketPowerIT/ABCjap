//
//  ChildCoordinatorQuiz.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import Foundation
import UIKit

final class ChildCoordinatorQuiz: AppCoordinatorProtocol {
    
    var navigatorController: UINavigationController
    var parentCoordinator:TabCoordinator?
    var secondVC: QuizViewController!
    private var vm: QuizViewModel!
    
    init(navigationController: UINavigationController) {
        self.navigatorController = navigationController
    }
    
    func Start() {
        self.navigatorController.pushViewController(self.secondVC, animated: false)
    }
    
    func initVC(){
        vm = QuizViewModel()
        self.secondVC = QuizViewController(vm: vm)
        self.secondVC.coordinator = self
    }
    
//    func goToDetail(data: CurrentCoctailDetail){
//        let detailVM = DetailViewModel(item: data)
//
//        let detailVC = DetailViewController()
//        detailVC.configureDetail(viewModel: detailVM)
//
//        self.navigatorController.pushViewController(detailVC,animated: false)
//    }
    
    
}
