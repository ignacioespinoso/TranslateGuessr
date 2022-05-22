//
//  EvaluatorView.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//

import UIKit

protocol EvaluatorViewProtocol: UIView {
    func configure(display: EvaluatorView.ViewModel)
}

class EvaluatorView: UIView, EvaluatorViewProtocol {
    private let correctAnswerCounterLabel: UILabel = UILabel()
    private let wrongAnswerCounterLabel: UILabel = UILabel()
    var interactor: EvaluatorRequestProcessor?
    
    private let sourceWordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 38.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let translatedWordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let correctAnswerButton: UIButton = UIButton()
    private let wrongAnswerButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension EvaluatorView: ViewCodable {
    func setupHierarchy() {
        addSubview(correctAnswerCounterLabel)
        addSubview(wrongAnswerCounterLabel)
        
        addSubview(translatedWordLabel)
        addSubview(sourceWordLabel)
        
        addSubview(correctAnswerButton)
        addSubview(wrongAnswerButton)
    }
    
    func setupConstraints() {
        setupAttemptCounterConstraints()
        setupTranslationsConstraints()
        setupEvaluationButtonsConstraints()
    }
    
    func setupUIAttributes() {
        backgroundColor = .systemBackground
        
        setupAnswerCountersUIAttributes()
        setupTranslationsUIAttributes()
        setupEvaluationButtonsUIAttributes()
    }
    
    private func setupAttemptCounterConstraints() {
        constrain([
            correctAnswerCounterLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
            correctAnswerCounterLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            correctAnswerCounterLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0)
        ])
        
        constrain([
            wrongAnswerCounterLabel.topAnchor.constraint(equalTo: correctAnswerCounterLabel.bottomAnchor, constant: 8.0),
            wrongAnswerCounterLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
        ])
    }
    
    private func setupTranslationsConstraints() {
        constrain([
            sourceWordLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -20.0),
            sourceWordLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            sourceWordLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
            
        ])
        
        constrain([
            translatedWordLabel.topAnchor.constraint(equalTo: sourceWordLabel.bottomAnchor, constant: 40.0),
            translatedWordLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            translatedWordLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
            
        ])
    }
    
    private func setupEvaluationButtonsConstraints() {
        constrain([
            correctAnswerButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            correctAnswerButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            correctAnswerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
        
        constrain([
            wrongAnswerButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            wrongAnswerButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            wrongAnswerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupAnswerCountersUIAttributes() {
        let answerCounterFont: UIFont = .systemFont(ofSize: 12.0, weight: .bold)
        correctAnswerCounterLabel.font = answerCounterFont
        correctAnswerCounterLabel.textAlignment = .left
        
        wrongAnswerCounterLabel.font = answerCounterFont
        wrongAnswerCounterLabel.textAlignment = .left
    }
    
    private func setupTranslationsUIAttributes() {
        sourceWordLabel.textAlignment = .center
        sourceWordLabel.adjustsFontSizeToFitWidth = true
        translatedWordLabel.textAlignment = .center
        translatedWordLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupEvaluationButtonsUIAttributes() {
        setupButton(button: self.correctAnswerButton,
                    title: "Correct",
                    backgroundColor: .systemGreen,
                    action: #selector(self.tappedAsCorrect))
        
        setupButton(button: self.wrongAnswerButton,
                    title: "Wrong",
                    backgroundColor: .systemRed,
                    action: #selector(self.tappedAsWrong))
    }
    
    private func setupButton(button: UIButton, title: String, backgroundColor: UIColor, action: Selector) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = .systemFont(ofSize: 24.0, weight: .bold)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.layer.cornerRadius = 6
    }
    
    @objc private func tappedAsCorrect() {
        interactor?.assessEvaluation(assessment: true)
    }
    
    @objc private func tappedAsWrong() {
        interactor?.assessEvaluation(assessment: false)
    }
}


extension EvaluatorView {
    struct ViewModel {
        let translatedWord: String
        let sourceWord: String
        
        var correctAttempts: Int
        var wrongAttempts: Int
    }
    
    func configure(display: ViewModel) {
        sourceWordLabel.text = display.sourceWord
        translatedWordLabel.text = display.translatedWord

        correctAnswerCounterLabel.text = "Correct Attempts: \(display.correctAttempts)"
        wrongAnswerCounterLabel.text = "Wrong Attempts: \(display.wrongAttempts)"
    }
}
