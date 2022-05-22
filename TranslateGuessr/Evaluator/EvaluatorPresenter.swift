//
//  EvaluatorPresenter.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//

protocol EvaluatorPresentationLogic {
    func present(content: TranslationPair, correctAttempts: Int, wrongAttempts: Int)
    func present(error: Error)
    func presentLoading()
}

final class EvaluatorPresenter {
    weak var controller: EvaluatorDisplayLogic?
}

extension EvaluatorPresenter: EvaluatorPresentationLogic {
    func present(content: TranslationPair, correctAttempts: Int, wrongAttempts: Int) {
        let viewModel = EvaluatorView.ViewModel(
            translatedWord: content.sourceString,
            sourceWord: content.targetString,
            correctAttempts: correctAttempts,
            wrongAttempts: wrongAttempts
        )

        controller?.display(content: viewModel)
    }

    func presentLoading() {
        controller?.displayLoading()
    }
    
    func present(error: Error) {
        controller?.displayError()
    }
}
