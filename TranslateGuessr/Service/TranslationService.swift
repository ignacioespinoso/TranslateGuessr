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
    func getRandomTranslationState(translations: [TranslationSet], correctOdds: Int) -> TranslationState
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
    
    func getRandomTranslationState(translations: [TranslationSet], correctOdds: Int) -> TranslationState {
        let sourceIndex = Int.random(in: 0..<translations.count)
        let isCorrectTranslation = shouldGetCorrectTranslation(correctOdds: correctOdds)
        var translationIndex = sourceIndex
        
        if (!isCorrectTranslation) {
            translationIndex = getWrongIndex(correctIndex: sourceIndex, arraySize: translations.count)
        }
        
        let translationPair = TranslationPair(sourceString: translations[sourceIndex].spanish,
                                              targetString: translations[translationIndex].english)
        return TranslationState(translationPair: translationPair, isCorrect: isCorrectTranslation)
    }
    
    private func getWrongIndex(correctIndex: Int, arraySize: Int) -> Int {
        var wrongIndex = Int.random(in: 0..<arraySize)
        while(wrongIndex == correctIndex) {
            wrongIndex = Int.random(in: 0..<arraySize)
        }
        return wrongIndex
    }
    
    private func shouldGetCorrectTranslation(correctOdds: Int) -> Bool {
        let value = Int.random(in: 0...100)
        return value <= correctOdds
    }
    
    private func complete(completion: @escaping (Result<[TranslationSet], Error>) -> Void, result: Result<[TranslationSet], Error>) {
        DispatchQueue.main.async { completion(result) }
    }
}
