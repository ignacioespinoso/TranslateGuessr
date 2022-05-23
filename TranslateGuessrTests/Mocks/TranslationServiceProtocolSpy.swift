//
//  TranslationServiceProtocolSpy.swift
//  TranslateGuessrTests
//
//  Created by Ignácio Ribeiro on 22/05/22.
//

@testable import TranslateGuessr

class TranslationServiceProtocolSpy: TranslationServiceProtocol {
    
    private(set) var fetchTranslationsCallCount: Int = 0
    var requestToBeCompleted: Result<[TranslationSet], Error>?
    
    func fetchTranslations(completion: @escaping (Result<[TranslationSet], Error>) -> Void) {
        fetchTranslationsCallCount += 1
        guard let value = requestToBeCompleted else { return }
        completion(value)
    }
    
    private(set) var getRandomTranslationStateTranslationsCalled: [[TranslationSet]] = []
    var translationStateToBeReturned: TranslationState?
    
    func getRandomTranslationState(translations: [TranslationSet], correctOdds: Int) -> TranslationState {
        getRandomTranslationStateTranslationsCalled.append(translations)
        return translationStateToBeReturned!
    }
}
