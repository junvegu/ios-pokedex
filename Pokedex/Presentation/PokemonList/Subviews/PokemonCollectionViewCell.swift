//
//  PokemonCollectionViewCell.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import UIKit
import BDRModel
import BDRUIComponents

class PokemonCollectionViewCell: UICollectionViewCell, ReusableView {
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Placeholder")
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var  titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bederrBold(18)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupUI() {
        contentView.backgroundColor = .primary
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        contentView.addBottomShadow()
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(titleLabel)
        pokemonImageView.image = UIImage(named: "Placeholder")
        
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pokemonImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            gradientView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradientView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with pokemon: Pokemon) {
        titleLabel.text = pokemon.name
        if let image = URL(string: pokemon.imageURL) {
            pokemonImageView.af.setImage(withURL: image)
        } else {
            pokemonImageView.image = UIImage(named: "Placeholder")
        }
    }
}
