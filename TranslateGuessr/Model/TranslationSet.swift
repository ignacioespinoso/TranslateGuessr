//
//  TranslationSet.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//

struct TranslationSet: Decodable {
    let english: String
    let spanish: String
    
    enum CodingKeys: String, CodingKey {
        case english = "text_eng"
        case spanish = "text_spa"
    }
}
