//
//  EvaluatorViewProtocolSpy.swift
//  TranslateGuessrTests
//
//  Created by Ignácio Ribeiro on 22/05/22.
//

import UIKit

@testable import TranslateGuessr

class EvaluatorViewProtocolSpy: UIView, EvaluatorViewProtocol {
    private(set) var configureDisplayCalled: [EvaluatorView.ViewModel] = []
    func configure(display: EvaluatorView.ViewModel) {
        configureDisplayCalled.append(display)
    }
}
