//
//  EvaluatorDisplayLogicSpy.swift
//  TranslateGuessrTests
//
//  Created by Ignácio Ribeiro on 22/05/22.
//

@testable import TranslateGuessr

class EvaluatorDisplayLogicSpy: EvaluatorDisplayLogic {
    private(set) var displayLoadingCallCount: Int = 0
    
    private(set) var displayContentCalled: [EvaluatorView.ViewModel] = []
    func display(content: EvaluatorView.ViewModel) {
        displayContentCalled.append(content)
    }

    func displayLoading() {
        displayLoadingCallCount += 1
    }

    private(set) var displayErrorCallCount: Int = 0
    func displayError() {
        displayErrorCallCount += 1
    }
}
