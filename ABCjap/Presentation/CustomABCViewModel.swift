//
//  CustomCellViewModel.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import Foundation

class CustomABCViewModel {
    
    var kana: String
    var roumaji: String
    
    init(model: ModelKanji) {
        self.kana = model.kana
        self.roumaji = model.roumaji
    }
}
