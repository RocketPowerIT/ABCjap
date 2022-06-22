//
//  ViewControllerQuiz.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import UIKit

class QuizViewController: UIViewController {
    weak var coordinator: ChildCoordinatorQuiz?
    
    let quizView:QuizView = {
        let view = QuizView()
        return view
    }()
    
    private var vm:QuizViewModel?
    
    init(vm:QuizViewModel) {
        super.init(nibName: nil, bundle: nil)
        quizView.quizViewController = self
        self.vm = vm
        configureQuizView(vm: self.vm!)
        addButtonSelector()
    }
    
    func configureQuizView(vm: QuizViewModel){
        quizView.updateUIWith(question: (vm.getCurrentQuestion()))
    }
    
    func addButtonSelector(){
        
        quizView.btnArray[0].addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        quizView.btnArray[1].addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        quizView.btnArray[2].addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        quizView.btnArray[3].addTarget(self, action: #selector(btnAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .red
        super.viewDidLoad()
    }

    @objc func btnAction(sender: UIButton!) {
        let a1 = sender.titleLabel?.text
        let a2 = vm?.getCurrentQuestion().roumaji
        vm?.action?(a1!, a2!)
        
        vm?.nextQuestion()
        configureQuizView(vm: vm!)
       
    }
}
