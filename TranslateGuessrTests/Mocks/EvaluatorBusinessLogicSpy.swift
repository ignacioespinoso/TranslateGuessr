//
//  EvaluatorBusinessLogicSpy.swift
//  TranslateGuessrTests
//
//  Created by Ignácio Ribeiro on 22/05/22.
//

@testable import TranslateGuessr

class EvaluatorBusinessLogicSpy: EvaluatorBusinessLogic {
    private(set) var loadCallCount: Int = 0
    
    func load() {
        loadCallCount += 1
    }
}
