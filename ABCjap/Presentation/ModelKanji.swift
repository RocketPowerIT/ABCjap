//
//  CardsItemModel.swift
//  ABCjap
//
//  Created by mac on 29/03/2022.
//

import Foundation

struct AllKanji: Codable {
    let cardsList: [ModelKanji]
}

struct ModelKanji: Codable {
    var kana: String
    var roumaji: String
}


