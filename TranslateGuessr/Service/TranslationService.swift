//
//  TranslationService.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//

import Foundation
import UIKit

protocol TranslationServiceProtocol {
    func fetchTranslations(completion: @escaping (Result<[TranslationSet], Error>) -> Void)
}

class TranslationService: TranslationServiceProtocol {
    func fetchTranslations(completion: @escaping (Result<[TranslationSet], Error>) -> Void) {    
        let asset = NSDataAsset(name: "words", bundle: Bundle.main)
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode([TranslationSet].self, from: asset!.data)
            complete(completion: completion, result: .success(result))
        } catch {
            complete(completion: completion, result: .failure(error))
        }
    }
    
    private func complete(completion: @escaping (Result<[TranslationSet], Error>) -> Void, result: Result<[TranslationSet], Error>) {
        DispatchQueue.main.async { completion(result) }
    }
}
