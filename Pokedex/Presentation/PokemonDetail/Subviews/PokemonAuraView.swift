//
//  PokemonAuraView.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 17/02/25.
//

import Foundation
import UIKit

final class PokemonAuraView: UIView {
    private let auraView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAura()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAura() {
        auraView.layer.cornerRadius = 150
        auraView.layer.shadowRadius = 80
        auraView.layer.shadowOpacity = 0.8
        auraView.layer.shadowOffset = .zero
        auraView.layer.masksToBounds = false
        auraView.alpha = 0.7
        
        addSubview(auraView)
        auraView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            auraView.centerXAnchor.constraint(equalTo: centerXAnchor),
            auraView.centerYAnchor.constraint(equalTo: centerYAnchor),
            auraView.widthAnchor.constraint(equalToConstant: 300),
            auraView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    func setAuraColor(_ color: UIColor) {
        auraView.backgroundColor = color.withAlphaComponent(0.6)
        auraView.layer.shadowColor = color.cgColor
    }
}

