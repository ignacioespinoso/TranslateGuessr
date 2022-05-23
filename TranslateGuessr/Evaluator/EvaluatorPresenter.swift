//
//  EvaluatorPresenter.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//

protocol EvaluatorPresentationLogic {
    func present(content: EvaluatorContent)
    func present(error: Error)
}

final class EvaluatorPresenter {
    weak var controller: EvaluatorDisplayLogic?
}

struct EvaluatorContent {
    let translationPair: TranslationPair
    let correctAttempts: Int
    let wrongAttempts: Int
}

extension EvaluatorPresenter: EvaluatorPresentationLogic {
    func present(content: EvaluatorContent) {
        let viewModel = EvaluatorView.ViewModel(
            translatedWord: content.translationPair.targetString,
            sourceWord: content.translationPair.sourceString,
            correctAttempts: content.correctAttempts,
            wrongAttempts: content.wrongAttempts
        )

        controller?.display(content: viewModel)
    }

    func present(error: Error) {
        controller?.displayError()
    }
}
