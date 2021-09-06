//
//  ViewCoding.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 11/07/21.
//

import Foundation

protocol ViewCoding {
    func buildViewHierarchy()
    func setupConstraints()
    func configure()
    func render()
}

extension ViewCoding {
    func configure() {}
}

extension ViewCoding {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        configure()
        render()
    }
}
