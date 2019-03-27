//
//  ArtistDetailsViewController.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol ArtistDetailsDisplayLogic: class
{
    func displayArtistAlbums(viewModel: ArtistDetails.FetchArtistAlbums.ViewModel)
    func showError(message: String)
}

class ArtistDetailsViewController: UIViewController, ArtistDetailsDisplayLogic, NVActivityIndicatorViewable
{
    var interactor: ArtistDetailsBusinessLogic?
    var router: (NSObjectProtocol & ArtistDetailsRoutingLogic & ArtistDetailsDataPassing)?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var displayedArtistAlbums: [ArtistDetails.FetchArtistAlbums.ViewModel.DisplayedArtistAlbum] = []
    
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
        let interactor = ArtistDetailsInteractor()
        let presenter = ArtistDetailsPresenter()
        let router = ArtistDetailsRouter()
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
        refreshControl.addTarget(self, action: #selector(fetchArtistAlbums), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        emptyLabel.isHidden = false
        setupTheme()
        fetchArtistAlbums()
        setupCollectionView()
    }
    
    
    //Set Theme()
    func setupTheme() {
        navigationController?.navigationBar.barTintColor = DefaultColors.grayColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: DefaultFonts.RobotoRegular as Any]
        self.navigationItem.title = interactor?.getArtistName()
        view.backgroundColor = DefaultColors.graySelectedColor
        self.navigationItem.hidesBackButton = true
        let image = UIImage(named: "back")
        let renderedImage = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        let backButton = UIBarButtonItem(image: renderedImage, style: .plain, target: self, action: #selector(backAction))
        backButton.tintColor = DefaultColors.greenColor
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: Methods
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func fetchArtistAlbums()
    {
        let size = CGSize(width: 40, height: 40)
        startAnimating(size, message: "Searching Albums", type: .semiCircleSpin, fadeInAnimation: nil)
        let request = ArtistDetails.FetchArtistAlbums.Request()
        interactor?.fetchArtistAlbums(request: request)
    }
    
    func displayArtistAlbums(viewModel: ArtistDetails.FetchArtistAlbums.ViewModel)
    {
        refreshControl.endRefreshing()
        self.stopAnimating(nil)
        displayedArtistAlbums = viewModel.displayedArtistAlbums
        emptyLabel.isHidden = displayedArtistAlbums.count > 0
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        self.showToast(message: message)
    }
}


// MARK: - UICollectionView Delegates implementation
extension ArtistDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func setupCollectionView() {
        collectionView?.register(UINib(nibName: String(describing: ArtistDetailsCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ArtistDetailsCell.self))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return displayedArtistAlbums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let displayedArtistAlbum = displayedArtistAlbums[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ArtistDetailsCell.self), for: indexPath) as? ArtistDetailsCell else { return UICollectionViewCell() }
        
        cell.setup(withDisplayedArtistAlbum: displayedArtistAlbum)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.selectAlbumBy(index: indexPath.row)
        router?.showSelectedArtistAlbum()
    }
}

