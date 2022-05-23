//
//  EvaluatorInteractor.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//

import Foundation

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
    private let presenter: EvaluatorPresentationLogic
    private var state: EvaluatorState
    private var timer: Timer?
    
    init(
        service: TranslationServiceProtocol,
        presenter: EvaluatorPresentationLogic,
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
            if (model.count > 1) {
                self.state.currentTranslationState = service.getRandomTranslationState(translations: model, correctOdds: 25)
                presenter.present(content: EvaluatorContent(
                    translationPair: self.state.currentTranslationState.translationPair,
                    correctAttempts: self.state.correctAnswersAmount,
                    wrongAttempts: self.state.wrongAnswersAmount)
                )
                self.startTimer()
            } else {
                presenter.present(error: EvaluatorBusinessLogicError.missingTranslations)
            }
            
        case .failure(let error):
            presenter.present(error: error)
        }
    }
    
    private func startTimer() {
        guard self.timer == nil else { return }

        self.timer = Timer.scheduledTimer(
            timeInterval: 5.0,
            target: self,
            selector: #selector(handleTimeout),
            userInfo: nil,
            repeats: false
        )
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc private func handleTimeout() {
        self.stopTimer()
        self.state.wrongAnswersAmount += 1
        self.evaluateEndScenario()
        self.load()
    }
    
    private func evaluateEndScenario() {
        if (self.state.wrongAnswersAmount >= 3 || self.state.correctAnswersAmount + self.state.wrongAnswersAmount >= 15) {
            self.endGame()
        }
    }
    
    private func endGame() {
        exit(EXIT_SUCCESS)
    }
}

extension EvaluatorInteractor: EvaluatorRequestProcessor {
    func assessEvaluation(assessment: Bool) {
        self.stopTimer()
        if (assessment == self.state.currentTranslationState.isCorrect) {
            self.state.correctAnswersAmount += 1
        } else {
            self.state.wrongAnswersAmount += 1
        }
        self.evaluateEndScenario()
        self.load()
    }
}

enum EvaluatorBusinessLogicError: Error {
    case missingTranslations
}
