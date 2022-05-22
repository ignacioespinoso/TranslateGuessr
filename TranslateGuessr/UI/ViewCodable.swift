//
//  ViewCodable.swift
//  TranslateGuessr
//
//  Created by Ignácio Ribeiro on 21/05/22.
//


import UIKit

protocol ViewCodable {
    func setup()
    func setupHierarchy()
    func setupTranslateMasks()
    func setupConstraints()
    func setupUIAttributes()
}

extension ViewCodable {
    func setup() {
        setupHierarchy()
        setupTranslateMasks()
        setupConstraints()
        setupUIAttributes()
    }
    
    func setupTranslateMasks() {}
    func setupUIAttributes() {}
}

extension ViewCodable where Self: UIView {
    func setupTranslateMasks() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
