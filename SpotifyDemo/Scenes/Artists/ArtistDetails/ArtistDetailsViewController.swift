//
//  ArtistDetailsViewController.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol ArtistDetailsDisplayLogic: class
{
    func displayArtistAlbums(viewModel: ArtistDetails.FetchArtistAlbums.ViewModel)
}

class ArtistDetailsViewController: UIViewController, ArtistDetailsDisplayLogic
{
    var interactor: ArtistDetailsBusinessLogic?
    var router: (NSObjectProtocol & ArtistDetailsRoutingLogic & ArtistDetailsDataPassing)?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var displayedArtistAlbums: [ArtistDetails.FetchArtistAlbums.ViewModel.DisplayedArtistAlbum] = []
    
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
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchArtistAlbums()
        setupCollectionView()
    }
    
    // MARK: Methods
    
    func fetchArtistAlbums()
    {
        let request = ArtistDetails.FetchArtistAlbums.Request()
        interactor?.fetchArtistAlbums(request: request)
    }
    
    func displayArtistAlbums(viewModel: ArtistDetails.FetchArtistAlbums.ViewModel)
    {
        displayedArtistAlbums = viewModel.displayedArtistAlbums
        collectionView.reloadData()
    }
}


// MARK: - UICollectionView Delegates implementation
extension ArtistDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.white
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
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

