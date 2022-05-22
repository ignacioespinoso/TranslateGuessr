//
//  EvaluatorSceneConfigurator.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//

import UIKit

struct EvaluatorSceneConfigurator {
    func build() -> UIViewController {
        let evaluatorService = TranslationService()
        let presenter = EvaluatorPresenter()
        
        let interactor = EvaluatorInteractor(
            service: evaluatorService,
            presenter: presenter,
            state: getInitialEvaluatorState()
        )
        
        let view = EvaluatorView()
        view.interactor = interactor
        let controller = EvaluatorViewController(
            view: view,
            interactor: interactor
        )
        
        presenter.controller = controller
        return controller
    }
    
    func getInitialEvaluatorState() -> EvaluatorState{
        let translationPair = TranslationPair(sourceString: "", targetString: "")
        let translationState = TranslationState(translationPair: translationPair, isCorrect: false)
        return EvaluatorState(currentTranslation: translationState)
    }
}

