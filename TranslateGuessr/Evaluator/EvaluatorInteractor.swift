//
//  EvaluatorInteractor.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//

protocol EvaluatorBusinessLogic {
    func load()
}

protocol EvaluatorRequestProcessor {
    func assessEvaluation(assessment: Bool)
}

final class EvaluatorState {
    var currentTranslationState: TranslationState
    var correctAnswersAmount: Int
    var wrongAnswersAmount: Int
    
    init(
        currentTranslation: TranslationState
    ) {
        self.currentTranslationState = currentTranslation
        self.correctAnswersAmount = 0
        self.wrongAnswersAmount = 0
    }
}

class TranslationState {
    let translationPair: TranslationPair
    let isCorrect: Bool
    
    init(translationPair: TranslationPair, isCorrect: Bool) {
        self.translationPair = translationPair
        self.isCorrect = isCorrect
    }
}

final class EvaluatorInteractor {
    private let service: TranslationServiceProtocol
    private let presenter: EvaluatorPresenter
    private var state: EvaluatorState

    
    init(
        service: TranslationServiceProtocol,
        presenter: EvaluatorPresenter,
        state: EvaluatorState
    ) {
        self.service = service
        self.presenter = presenter
        self.state = state

    }
    
    func loadInitialState() -> EvaluatorState {
        let translationPair = TranslationPair(sourceString: "", targetString: "")
        let translationState = TranslationState(translationPair: translationPair, isCorrect: false)
        return EvaluatorState(currentTranslation: translationState)
    }
    
    
}

extension EvaluatorInteractor: EvaluatorBusinessLogic {
    func load() {
        service.fetchTranslations { [weak self] result in
            self?.handleLoad(result: result)
        }
    }
    
    private func handleLoad(result: Result<[TranslationSet], Error>) {
        switch result {
        case .success(let model):
            self.state.currentTranslationState = getRandomTranslationState(translations: model)
            presenter.present(content: self.state.currentTranslationState.translationPair,
                              correctAttempts: state.correctAnswersAmount,
                              wrongAttempts: state.wrongAnswersAmount)
        case .failure(let error):
            presenter.present(error: error)
        }
    }
    
    private func getRandomTranslationState(translations: [TranslationSet]) -> TranslationState {
        let sourceIndex = Int.random(in: 0..<translations.count)
        let isCorrectTranslation = shouldGetCorrectTranslation()
        var translationIndex = sourceIndex
        
        if (!isCorrectTranslation) {
            translationIndex = getWrongIndex(correctIndex: sourceIndex, arraySize: translations.count)
        }
        
        let translationPair = TranslationPair(sourceString: translations[sourceIndex].english, targetString: translations[translationIndex].spanish)
        return TranslationState(translationPair: translationPair, isCorrect: isCorrectTranslation)
    }
    
    private func getWrongIndex(correctIndex: Int, arraySize: Int) -> Int {
        var wrongIndex = Int.random(in: 0..<arraySize)
        while(wrongIndex == correctIndex) {
            wrongIndex = Int.random(in: 0..<arraySize)
        }
        return wrongIndex
    }
    
    private func shouldGetCorrectTranslation() -> Bool {
        let value = Int.random(in: 0...4)
        return value == 1
    }
}

extension EvaluatorInteractor: EvaluatorRequestProcessor {
    func assessEvaluation(assessment: Bool) {
        if (assessment == self.state.currentTranslationState.isCorrect) {
            self.state.correctAnswersAmount += 1
        } else {
            self.state.wrongAnswersAmount += 1
        }
        self.load()
    }
}
