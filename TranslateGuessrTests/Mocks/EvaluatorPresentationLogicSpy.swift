//
//  EvaluatorPresentationLogicSpy.swift
//  TranslateGuessrTests
//
//  Created by Ignácio Ribeiro on 22/05/22.
//

@testable import TranslateGuessr

class EvaluatorPresentationLogicSpy: EvaluatorPresentationLogic {
    private(set) var presentContentCalled: [EvaluatorContent] = []
    func present(content: EvaluatorContent) {
        presentContentCalled.append(content)
    }
    
    private(set) var presentErrorCalled: [Error] = []
    func present(error: Error) {
        presentErrorCalled.append(error)
    }
}
