//
//  EvaluatorViewController.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//

import UIKit

protocol EvaluatorDisplayLogic: AnyObject {
    func display(content: EvaluatorView.ViewModel)
    func displayError()
}

final class EvaluatorViewController: UIViewController {
    private let customView: EvaluatorViewProtocol
    private let interactor: EvaluatorBusinessLogic
    
    init(
        view: EvaluatorViewProtocol,
        interactor: EvaluatorBusinessLogic
    ) {
        self.customView = view
        self.interactor = interactor

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.load()
    }
}

extension EvaluatorViewController: EvaluatorDisplayLogic {
    func display(content: EvaluatorView.ViewModel) {
        customView.configure(display: content)
    }
    
    func displayError() {
        print("Display error!")
    }
}

