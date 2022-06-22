//
//  ViewModelCards.swift
//  ABCjap
//
//  Created by mac on 29/03/2022.
//

import Foundation

enum ERROR_ENUM: Error {
    case JSON_ERROR(str:String)
}

class ViewModel {

    private var cellItem = [CustomABCViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var reloadTableView: (() -> Void)?
    
    func getCountCell() -> Int
    {
        return cellItem.count
    }
    
    func getCellVM(at indexPath: IndexPath) -> CustomABCViewModel
    {
        return self.cellItem[indexPath.row]
    }

    init(){
        fetchItems()
    }
    
    func createCellModel(model: ModelKanji)->CustomABCViewModel{
        let roumaji = model.roumaji
        let kanji = model.kana
        let modelItem = ModelKanji(kana: kanji, roumaji: roumaji)
        return CustomABCViewModel(model: modelItem)
     }
    
    func fetchItems() {
        self.getCardListOffline {(result) in
            switch result {
            case .success(let card):
               
                var vmc = [CustomABCViewModel]()
                for item in card {
                    vmc.append(self.createCellModel(model: item))
                }
                self.cellItem           = vmc
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
