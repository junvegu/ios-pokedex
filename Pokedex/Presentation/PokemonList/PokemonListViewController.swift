//
//  PokemonListViewController.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import UIKit
import BDRModel
import Combine
import BDRUIComponents

protocol PokemonListView: BaseView {
    var onCompletion: BDRCompletionFlowBlock? { get set }
}

final class PokemonListViewController: UIViewController, PokemonListView {
    var onCompletion: BDRCompletionFlowBlock?
    
    private lazy var collectionView: UICollectionView = {
        let layout = RecipesCollectionLayout.createLayout(isTwoColumn: isTwoColumnLayout)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier
        )
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(refreshControl)
        return collectionView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(loadData),
                                 for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .primary
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let viewModel: PokemonListViewModel
    private var subscribers = Set<AnyCancellable>()
    private let searchController = UISearchController(searchResultsController: nil)
    private var isTwoColumnLayout: Bool = true

 
    private var pokemons: [Pokemon] = [] {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    init(viewModel: PokemonListViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.bind(.onViewReady)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        definesPresentationContext = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: - Bind events
    private func bindView() {
        bindStates()
    }
    
    private func bindStates() {
        viewModel.liveData
            .$state
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .idle:
                    self.refreshControl.endRefreshing()
                    self.activityIndicator.stopAnimating()
                case .error(let error):
                    self.refreshControl.endRefreshing()
                    print(error.localizedDescription)
                    self.activityIndicator.stopAnimating()
                case .loading:
                    self.refreshControl.beginRefreshing()
                    self.activityIndicator.startAnimating()
                case .success(let pokemons):
                    self.pokemons = pokemons
                    self.refreshControl.endRefreshing()
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.5) {
                        self.view.layoutIfNeeded()
                    }
                case .searchResults(let pokemons):
                    self.pokemons = pokemons
                    self.activityIndicator.stopAnimating()
                }
            }.store(in: &subscribers)
    }
}

private extension PokemonListViewController {
    func setupView() {
        setupNavigationBar()
        setupSearchBar()
        setupCollectionView()
        setupIndicator()
    }
    
    private func setupNavigationBar() {
        view.backgroundColor = .secondary

        let toggleLayoutButton = UIBarButtonItem(
            title: "Change View",
            style: .plain,
            target: self,
            action: #selector(toggleLayout)
        )
        navigationItem.rightBarButtonItem = toggleLayoutButton
    }
    
    
    @objc private func toggleLayout() {
        isTwoColumnLayout.toggle()
        
        UIView.animate(withDuration: 0.3) {
            self.collectionView.setCollectionViewLayout(
                RecipesCollectionLayout.createLayout(isTwoColumn: self.isTwoColumnLayout), animated: true
            )
        }
    }

    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchTextField.placeholder = "Busca por nombre o ingrediente"
        searchController.searchBar.searchTextField.font = .bederrRegular(16)
        searchController.searchBar.searchTextField.accessibilityIdentifier = "searchBar"

        let textFieldPublisher = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
            .map {
                ($0.object as? UITextField)?.text
            }
        textFieldPublisher
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink ( receiveValue: { [weak self] value in
                self?.viewModel.bind(.onSearchPokemon(value ?? ""))
            })
            .store(in: &subscribers)
    }
    
    private func setupIndicator() {
        view.addSubview(activityIndicator)
           
           NSLayoutConstraint.activate([
               activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
           ])
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func loadData() {
        viewModel.bind(.onRefreshPokemon)
    }
    
}

extension PokemonListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: pokemons[indexPath.item])
        cell.accessibilityIdentifier = pokemons[indexPath.item].id.description
        return cell
    }
}

extension PokemonListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.bind(.didTapPokemon(pokemons[indexPath.item]))
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.bind(.onRefreshPokemon)
    }
}
