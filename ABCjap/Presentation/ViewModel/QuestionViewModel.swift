//
//  QuestionsQuizViewModel.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import Foundation

class QuestionViewModel {
    
    var kana: String
    var roumaji: String
    var answer: [String] = []
    
    init(kana:String, romanji:String, answ:[String]) {
        self.kana = kana
        self.roumaji = romanji
        answer=answ
    }
    
}
