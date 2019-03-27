//
//  ArtistListViewController.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol ArtistListDisplayLogic: class
{
    func displayArtists(viewModel: ArtistList.FetchArtists.ViewModel)
    func showError(message: String)
}

class ArtistListViewController: UIViewController, ArtistListDisplayLogic, NVActivityIndicatorViewable
{
    var interactor: ArtistListBusinessLogic?
    var router: (NSObjectProtocol & ArtistListRoutingLogic & ArtistListDataPassing)?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var displayedArtists: [ArtistList.FetchArtists.ViewModel.DisplayedArtist] = []
    
    private let refreshControl = UIRefreshControl()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var emptyLabel: UILabel!{
        didSet {
            emptyLabel.textColor = DefaultColors.artistNameColor
            emptyLabel.font = DefaultFonts.RobotoRegular
        }
    }
    
    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ArtistListInteractor()
        let presenter = ArtistListPresenter()
        let router = ArtistListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        refreshControl.tintColor = DefaultColors.greenColor
        refreshControl.addTarget(self, action: #selector(fetchArtists), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        emptyLabel.isHidden = false
        setUpSearchBar()
        setupTheme()
        setupCollectionView()
    }
    
    // MARK: Methods
    
    //Set Theme()
    func setupTheme() {
        navigationController?.navigationBar.barTintColor = DefaultColors.grayColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: DefaultFonts.RobotoRegular as Any]
        view.backgroundColor = DefaultColors.graySelectedColor
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setUpSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Artist"
        searchController.searchBar.tintColor = DefaultColors.greenColor
        searchController.searchBar.barTintColor = .white
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        navigationItem.titleView = searchController.searchBar
    }
    
    @objc func fetchArtists()
    {
        let size = CGSize(width: 40, height: 40)
        startAnimating(size, message: "Searching Artists", type: .semiCircleSpin, fadeInAnimation: nil)
        let request = ArtistList.FetchArtists.Request(artistName: searchController.searchBar.text!)
        interactor?.fetchArtists(request: request)
    }
    
    func displayArtists(viewModel: ArtistList.FetchArtists.ViewModel)
    {
        refreshControl.endRefreshing()
        self.stopAnimating(nil)
        displayedArtists = viewModel.displayedArtists
        emptyLabel.isHidden = displayedArtists.count > 0
        collectionView.reloadData()
    }
    
    func showError(message: String){
        refreshControl.endRefreshing()
        self.stopAnimating(nil)
        self.showToast(message: message)
    }
}

// SerarchBar delegate
extension ArtistListViewController: UISearchResultsUpdating {
    
    @IBAction func toggleSearchBar(){
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if !searchBarIsEmpty() {
            fetchArtists()
        } else {
            emptyLabel.isHidden = false
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
}


// MARK: - UICollectionView Delegates implementation
extension ArtistListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func setupCollectionView() {
        collectionView?.register(UINib(nibName: String(describing: ArtistListCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ArtistListCell.self))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return displayedArtists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let displayedArtist = displayedArtists[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ArtistListCell.self), for: indexPath) as? ArtistListCell else { return UICollectionViewCell() }
        
        cell.setup(withDisplayedArtist: displayedArtist)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.selectArtistBy(index: indexPath.row)
        router?.showSelectedArtist()
    }
}

