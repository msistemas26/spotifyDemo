//
//  AlbumDetailsViewController.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 27/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol AlbumDetailsDisplayLogic: class
{
    func displayAlbums(viewModel: AlbumDetails.FetchAlbums.ViewModel)
}

class AlbumDetailsViewController: UIViewController, AlbumDetailsDisplayLogic
{
    var interactor: AlbumDetailsBusinessLogic?
    var router: (NSObjectProtocol & AlbumDetailsRoutingLogic & AlbumDetailsDataPassing)?
    var displayedAlbums: [AlbumDetails.FetchAlbums.ViewModel.DisplayedAlbum] = []
    
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
        let interactor = AlbumDetailsInteractor()
        let presenter = AlbumDetailsPresenter()
        let router = AlbumDetailsRouter()
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
        fetchAlbums()
        setUpTableView()
    }
    
    // MARK: Methods
    
    func fetchAlbums()
    {
        let request = AlbumDetails.FetchAlbums.Request()
        interactor?.fetchAlbums(request: request)
    }
    
    func displayAlbums(viewModel: AlbumDetails.FetchAlbums.ViewModel)
    {
        displayedAlbums = viewModel.displayedAlbums
    }
}

