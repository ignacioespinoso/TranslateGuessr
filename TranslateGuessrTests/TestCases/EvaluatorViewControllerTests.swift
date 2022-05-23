//
//  EvaluatorViewControllerTests.swift
//  TranslateGuessrTests
//
//  Created by Ignácio Ribeiro on 22/05/22.
//

import XCTest

@testable import TranslateGuessr

final class EvaluatorViewControllerTests: XCTestCase {
    private let viewSpy = EvaluatorViewProtocolSpy()
    private let interactorSpy = EvaluatorBusinessLogicSpy()
    private lazy var sut = EvaluatorViewController(view: viewSpy, interactor: interactorSpy)

    func test_loadView_shouldSetCustomView() {
        sut.loadView()

        XCTAssertEqual(sut.view === viewSpy, true)
    }

    func test_viewDidLoad_shouldCallLoad() {
        sut.viewDidLoad()

        XCTAssertEqual(interactorSpy.loadCallCount, 1)
    }

    func test_display_shouldConfigureView() {
        let sourceString = "Source"
        let translatedString = "Target"
        let correctAttempts = 5
        let wrongAttempts = 2
        
        sut.display(content: .init(translatedWord: translatedString,
                                   sourceWord: sourceString,
                                   correctAttempts: correctAttempts,
                                   wrongAttempts: wrongAttempts)
        )

        XCTAssertEqual(viewSpy.configureDisplayCalled.count, 1)
    }
}
