//
//  EvaluatorInteractorTests.swift
//  TranslateGuessrTests
//
//  Created by Ignácio Ribeiro on 22/05/22.
//

import XCTest

@testable import TranslateGuessr

final class EvaluatorInteractorTests: XCTestCase {
    private let serviceSpy = TranslationServiceProtocolSpy()
    private let presenterSpy = EvaluatorPresentationLogicSpy()
    private let initialState = EvaluatorState(
        currentTranslation: TranslationState(
            translationPair: TranslationPair(
                sourceString: "Source",
                targetString: "Target"
            ),
            isCorrect: true
        )
    )
    
    private lazy var sut = EvaluatorInteractor(service: serviceSpy, presenter: presenterSpy, state: initialState)

    func test_load_whenSuccess_andHaveEmptyTranslations_shouldCallErrorOnPresenter() {
        serviceSpy.requestToBeCompleted = Result<[TranslationSet], Error>.success([])

        sut.load()

        XCTAssertEqual(presenterSpy.presentContentCalled.count, 0)
        XCTAssertEqual(presenterSpy.presentErrorCalled.count, 1)
        XCTAssertEqual(presenterSpy.presentErrorCalled.first as? EvaluatorBusinessLogicError, EvaluatorBusinessLogicError.missingTranslations)
    }

    func test_load_whenSuccess_andHaveConsolidatedWeather_shouldCallContentOnPresenter() {
        let sourceString1 = "Source1"
        let translationString1 = "Translation1"
        let sourceString2 = "Source2"
        let translationString2 = "Translation2"
        
        let translation1 = TranslationSet(english: translationString1, spanish: sourceString1)
        let translation2 = TranslationSet(english: translationString2, spanish: sourceString2)
        
        serviceSpy.requestToBeCompleted = Result<[TranslationSet], Error>.success([translation1, translation2])
        serviceSpy.translationStateToBeReturned = TranslationState(
            translationPair: TranslationPair(
                sourceString: sourceString1,
                targetString: translationString1
            ),
            isCorrect: true
        )
        
        sut.load()

        XCTAssertEqual(presenterSpy.presentErrorCalled.count, 0)
        XCTAssertEqual(presenterSpy.presentContentCalled.count, 1)
        XCTAssertEqual(presenterSpy.presentContentCalled.first?.translationPair.sourceString, sourceString1)
        XCTAssertEqual(presenterSpy.presentContentCalled.first?.translationPair.targetString, translationString1)
        XCTAssertEqual(presenterSpy.presentContentCalled.first?.correctAttempts, 0)
        XCTAssertEqual(presenterSpy.presentContentCalled.first?.wrongAttempts, 0)
    }
}
