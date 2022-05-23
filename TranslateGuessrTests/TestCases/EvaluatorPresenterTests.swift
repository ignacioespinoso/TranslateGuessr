//
//  EvaluatorPresenterTests.swift
//  TranslateGuessrTests
//
//  Created by Ignácio Ribeiro on 22/05/22.
//

import XCTest

@testable import TranslateGuessr

final class EvaluatorPresenterTests: XCTestCase {
    private let controllerSpy = EvaluatorDisplayLogicSpy()
    private lazy var sut: EvaluatorPresenter = {
        let sut = EvaluatorPresenter()
        sut.controller = controllerSpy
        return sut
    }()
    
    func test_presentContent_shouldCallViewWithCorrectFormatedContent() {
        let sourceString = "Source"
        let targetString = "Target"
        let correctAttempts = 5
        let wrongAttempts = 2
        
        let content = EvaluatorContent(
            translationPair: TranslationPair(
                sourceString: sourceString,
                targetString: targetString
            ),
            correctAttempts: correctAttempts,
            wrongAttempts: wrongAttempts
        )
        sut.present(content: content)

        XCTAssertEqual(controllerSpy.displayContentCalled.count, 1)
        XCTAssertEqual(controllerSpy.displayContentCalled.first?.sourceWord, sourceString)
        XCTAssertEqual(controllerSpy.displayContentCalled.first?.translatedWord, targetString)
        XCTAssertEqual(controllerSpy.displayContentCalled.first?.correctAttempts, correctAttempts)
        XCTAssertEqual(controllerSpy.displayContentCalled.first?.wrongAttempts, wrongAttempts)
    }

}



