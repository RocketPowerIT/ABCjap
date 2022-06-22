//
//  CoordinatorTabABC.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import Foundation
import UIKit

final class CoordinatorTabABC: AppCoordinatorProtocol {
    
    var navigatorController: UINavigationController
    
    var vc: ViewController!
    private var vm: ViewModel!
    
    init(navigationController: UINavigationController) {
        self.navigatorController = navigationController
    }
    
    func Start() {
        self.navigatorController.pushViewController(self.vc, animated: false)
    }
    
    func initVC(){
        vm = ViewModel()
        self.vc = ViewController(vm: vm)
        vc.coordinator = self
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
