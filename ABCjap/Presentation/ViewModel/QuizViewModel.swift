//
//  ViewModel.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import Foundation

protocol  QuizViewModelDelegate : AnyObject {
   // func tapButton(tag: Int)
    var action: ((String,String) -> ())? { get set }
}
class QuizViewModel:QuizViewModelDelegate {
    
    var action: ((String,String) -> ())?
    
    var currentQuestion = 0;
    
    private var questionList = [QuestionViewModel]()
    private var answerList:[String]=[]
    
    private var questions:[QuestionViewModel]=[]
    
    init(){
        initQuiz()
    }
    
    func initQuiz(){
        fetchItems()
        questions = getQuastionList(countAnswer: 4)
        action = { [weak self] a1, a2 in
            self?.checkWin(answ1: a1, answ2: a2)
           }
    }
    
    func configureQuestion(_ view: QuizView, question:QuestionViewModel){
        view.updateUIWith(question: question)
    }
    
    func getCurrentQuestion()->QuestionViewModel{
        return questions[currentQuestion]
    }
    
    func nextQuestion(){
        currentQuestion+=1
    }
    
    func getCurrentIndexQuestion()->Int{
        return currentQuestion
    }
    
    func getCountQuestions()->Int{
        return questions.count
    }
    
    func configureBtn(withAction actn:(String,String) -> ()){
        
    }
    
    func checkWin(answ1 :String, answ2 :String){
        if(answ1 == answ2){
            print("equel")
        }else{
            print("wrong")
        }
    }
}

extension QuizViewModel {
    
    fileprivate func getQuastionList(countAnswer: Int)->[QuestionViewModel] {
        let l_questions = generateQuestion(question: questionList, answer: answerList, countAnswer: countAnswer)
        let l_questionShafle = l_questions.shuffled()
        return l_questionShafle
    }

   fileprivate func createQuestion(kana:String, romanji:String, answ:[String])->QuestionViewModel {
        let l_roumaji = romanji
        let l_kanji = kana
        let l_answ = answ
        return QuestionViewModel(kana: l_kanji, romanji: l_roumaji, answ: l_answ)
   }
    
    fileprivate func generateQuestion(question:[QuestionViewModel] ,answer: [String], countAnswer: Int)->[QuestionViewModel]{
        
        var l_question = [QuestionViewModel]()
        for i in 0...answer.count-1 {
            var set = Set<String>()
            let kanji = question[i].kana
            let roumaji = question[i].roumaji
            set.insert(roumaji)
            while(set.count<4){
                set.insert(answer.randomElement()!)
            }
            let item = createQuestion(kana: kanji, romanji: roumaji, answ: Array(set))
            l_question.append(item)
        }
        return l_question
    }
    
   fileprivate func fetchItems() {
        self.getCardListOffline {(result) in
            switch result {
            case .success(let card):
                var l_question = [QuestionViewModel]()
                var l_answer = [String]()
                for item in card {
                    l_question.append(QuestionViewModel(kana: item.kana, romanji: item.roumaji, answ: ["","","",""]))
                    l_answer.append(item.roumaji)
                }
                self.answerList = l_answer
                self.questionList = l_question
              
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func getCardListOffline(completion: @escaping (Result<[ModelKanji], ERROR_ENUM>) -> ()) {
          
        guard let filePath = Bundle.main.url(forResource: "hiragana",withExtension: "json") else {
            completion(.failure(.JSON_ERROR(str: "ERROR_FILE_PATH")))
            return }
          do {
              let data = try Data(contentsOf: filePath)
              let decoder = JSONDecoder()
              let jsonData = try decoder.decode([ModelKanji].self, from: data)
              
              completion(.success(jsonData))
          } catch {
              completion(.failure(.JSON_ERROR(str: "ERROR_READ_JSON")))
          }
      }
}
