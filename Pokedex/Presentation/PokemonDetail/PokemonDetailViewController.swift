//
//  PokemonDetailBuilder.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import BDRModel
import UIKit
import Combine
import SkeletonView
import BDRUIComponents

protocol PokemonDetailView: BaseView {
    var onCompletion: BDRCompletionFlowBlock? { get set }
}

final class PokemonDetailViewController: UIViewController, PokemonDetailView {
    var onCompletion: BDRCompletionFlowBlock?
    
    // MARK: - ViewModel
    private let viewModel: PokemonDetailViewModel
    private var subscribers = Set<AnyCancellable>()

    // MARK: - UI Components
    private lazy var auraView: PokemonAuraView = {
        let auraView = PokemonAuraView()
        auraView.translatesAutoresizingMaskIntoConstraints = false
        return auraView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        return view
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var pokemonNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .bederrBold(18)
        label.textColor = .label
        return label
    }()
    
    private lazy var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.font = .bederrBold(36)
        label.textColor = .label
        return label
    }()
    
    private lazy var pokemonSpeciesLabel: UILabel = {
        let label = UILabel()
        label.font = .bederrLight(12)
        label.textColor = .label
        return label
    }()
    
    private lazy var typesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .bederrRegular(16)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var statsContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.font =  .bederrRegular(16)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.font = .bederrRegular(16)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "Información General"
        label.font = .bederrBold(16)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    // MARK: - Init
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        viewModel.bind(.onViewReady)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.secondary
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        
        contentView.addSubview(auraView)
        [pokemonImageView,
         pokemonNumberLabel,
         pokemonNameLabel,
         pokemonSpeciesLabel,
         typesStackView,
         aboutLabel,
         descriptionLabel,
         statsContainerView].forEach {
            contentView.addSubview($0)
            $0.isSkeletonable = true
        }
        
        [weightLabel, heightLabel].forEach {
            statsContainerView.addArrangedSubview($0)
            $0.isSkeletonable = true
        }
        
        pokemonImageView.isSkeletonable = true
        pokemonImageView.skeletonCornerRadius = 20
        pokemonNumberLabel.linesCornerRadius = 5
        pokemonNameLabel.linesCornerRadius = 5
        descriptionLabel.numberOfLines = 3
        descriptionLabel.linesCornerRadius = 5

    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonSpeciesLabel.translatesAutoresizingMaskIntoConstraints = false
        typesStackView.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        statsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            /// ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            /// Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            auraView.centerXAnchor.constraint(equalTo: pokemonNameLabel.centerXAnchor),
            auraView.centerYAnchor.constraint(equalTo: pokemonNameLabel.centerYAnchor, constant: -50),
                       
            
            /// Pokemon Image
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            pokemonImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 240),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 240),
            
            /// Number Label
            pokemonNumberLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 12),
            pokemonNumberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            /// Name Label
            pokemonNameLabel.topAnchor.constraint(equalTo: pokemonNumberLabel.bottomAnchor, constant: 8),
            pokemonNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            /// Species Label
            pokemonSpeciesLabel.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 4),
            pokemonSpeciesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            /// Types Stack View
            typesStackView.topAnchor.constraint(equalTo: pokemonSpeciesLabel.bottomAnchor, constant: 16),
            typesStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            /// About Label
            aboutLabel.topAnchor.constraint(equalTo: typesStackView.bottomAnchor, constant: 32),
            aboutLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            aboutLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            /// Description Label
            descriptionLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            /// Stats Container
            statsContainerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            statsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statsContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            statsContainerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    // MARK: - ViewModel Binding
    private func bindViewModel() {
        viewModel.liveData
            .$state
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .idle:
                   break
                case .showPokemon(let detail):
                    self.contentView.hideSkeleton()
                    self.pokemonNumberLabel.text = "#\(String(format: "%03d", detail.base.id))"
                    self.pokemonNameLabel.text = detail.base.name.capitalized
                    self.pokemonSpeciesLabel.text = detail.description
                    self.descriptionLabel.text = detail.description
                    self.weightLabel.text = "⚖️ \(detail.weight) kg"
                    self.heightLabel.text = "📏 \(detail.height) m"
                    self.pokemonImageView.af.setImage(withURL: URL.init(string: detail.base.imageURL)!)
                    self.setupTypes(types: detail.types)
                    if let color = detail.types.first?.color {
                        self.auraView.setAuraColor(color)
                        let gradientLayer = CAGradientLayer()
                        gradientLayer.frame = view.bounds
                        gradientLayer.colors = [color.withAlphaComponent(0.5).cgColor, color.withAlphaComponent(0.1).cgColor]
                        gradientLayer.shouldRasterize = true
                        view.layer.insertSublayer(gradientLayer, at: 0)
                    }
                   
                case .error(_):
                    self.contentView.hideSkeleton()
                case .loading:
                    self.contentView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .white), animation: nil)
                }
            }.store(in: &subscribers)
    }
    
    private func setupTypes(types: [PokemonType]) {
        typesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for type in types {
            let label = UILabel()
            label.text = type.name.capitalized
            label.font = .bederrRegular(18)
            label.textColor = .label
            label.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            label.layer.cornerRadius = 12
            label.clipsToBounds = true
            label.textAlignment = .center
            label.widthAnchor.constraint(equalToConstant: 80).isActive = true
            label.heightAnchor.constraint(equalToConstant: 24).isActive = true
            typesStackView.addArrangedSubview(label)
        }
    }
}

#if DEBUG
import SwiftUI
import Foundation

struct PokemonDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            let vc = PokemonDetailViewBuilder()
                .setGetDetailPokemonUseCase()
                .setPokemon(pokemon: .init(id: 1, name: "Bolbasaaaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
                .build()
            return vc
        }
        .previewDevice("iPhone 14 Pro")
    }
}
#endif
