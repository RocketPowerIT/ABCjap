//
//  ViewQuiz.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import Foundation
import UIKit

class QuizView:UIView {

    weak var quizViewController:QuizViewController?{
          didSet{
              setupViewController()
          }
      }
    
    func setupViewController(){
        translatesAutoresizingMaskIntoConstraints = false
        if let vc = quizViewController {
            vc.view.addSubview(self)
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor),
                bottomAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.bottomAnchor),
                leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.trailingAnchor)
            ])
        }
    }
    
    func getButtonArray()->[UIButton]{
        return self.btnArray
    }
    

    var label = UILabel()
    var btnArray:[UIButton] = []
    
    private let mySpacing: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createStackedGrid(rows: 2, columns: 2)
    }
    
    func updateUIWith(question:QuestionViewModel){
        self.label.text = question.kana
        for i in 0...btnArray.count-1 {
            btnArray[i].setTitle(question.answer[i], for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createStackedGrid(rows: Int, columns: Int) {

        let questionSV = createStackViewView(axis: .vertical)
        let buttonSV = createStackViewView(axis: .vertical)
        
        for row in 0 ..< rows {
            let horizontalSV = createStackViewView(axis: .horizontal)
            
            for col in 0 ..< columns {
                let button = createButton()
                button.tag = row*10+col
                btnArray.append(button)
                
                horizontalSV.addArrangedSubview(button)
            }
            buttonSV.addArrangedSubview(horizontalSV)
        }
        let questionView = createQuestionsView()
        questionSV.addArrangedSubview(questionView)
        questionSV.addArrangedSubview(buttonSV)
        
        addSubview(questionSV)
        
        questionSV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionSV.centerXAnchor.constraint(equalTo: centerXAnchor,constant: 0),
            questionSV.centerYAnchor.constraint(equalTo: centerYAnchor),
            questionSV.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            questionSV.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        ])

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: questionView.centerXAnchor,constant: 0),
            label.centerYAnchor.constraint(equalTo: questionView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: questionView.widthAnchor, multiplier: 0.8),
            label.heightAnchor.constraint(equalTo: questionView.heightAnchor, multiplier: 0.8)
        ])
       }
}

extension QuizView {
    
    fileprivate func createQuestionsView()->UIView{
        let iv = UIView()
        iv.backgroundColor = .cyan
        label.text = "ddddddd"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name:"RemachineScript_Personal_Use", size: 100)
        label.font = label.font.withSize(80)
        iv.addSubview(label)
        return iv
    }
    
    fileprivate func createStackViewView(axis: NSLayoutConstraint.Axis)->UIStackView{
        let sv = UIStackView()
        sv.axis = axis
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = mySpacing
        return sv
    }
    
    fileprivate func createButton()->UIButton{
        let button = UIButton(type: .system)
        
        button.backgroundColor = .orange
        button.titleLabel?.font =  UIFont(name: "RemachineScript_Personal_Use", size: 68)
        button.setTitle("12", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 76)
        button.layer.cornerRadius = 6
        return button
    }
}
