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
    func displayAlbum(viewModel: AlbumDetails.FetchAlbums.ViewModel)
}

class AlbumDetailsViewController: UIViewController, AlbumDetailsDisplayLogic
{
    var interactor: AlbumDetailsBusinessLogic?
    var router: (NSObjectProtocol & AlbumDetailsRoutingLogic & AlbumDetailsDataPassing)?
    var displayedAlbum: AlbumDetails.FetchAlbums.ViewModel.DisplayedAlbum?
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet {
            nameLabel.textColor = DefaultColors.artistNameColor
            nameLabel.font = DefaultFonts.RobotoRegularTitle
        }
    }
    
    @IBOutlet weak var albumImage: UIImageView!{
        didSet {
            albumImage.backgroundColor = DefaultColors.graySelectedColor
        }
    }
    
    @IBOutlet weak var goToButtom: UIButton!{
        didSet {
            goToButtom.backgroundColor = DefaultColors.greenColor
            goToButtom.layer.cornerRadius = 10.0
        }
    }
    
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
    
    //Set Theme()
    func setupTheme() {
        navigationController?.navigationBar.barTintColor = DefaultColors.grayColor
        view.backgroundColor = DefaultColors.graySelectedColor
        self.navigationItem.hidesBackButton = true
        let image = UIImage(named: "back")
        let renderedImage = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        let backButton = UIBarButtonItem(image: renderedImage, style: .plain, target: self, action: #selector(backAction))
        backButton.tintColor = DefaultColors.greenColor
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToSpotify(_ sender: UIButton) {
        router?.openSpotify()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTheme()
        fetchAlbums()
    }
    
    // MARK: Methods
    
    func fetchAlbums()
    {
        interactor?.fetchAlbum()
    }
    
    func displayAlbum(viewModel: AlbumDetails.FetchAlbums.ViewModel)
    {
        displayedAlbum = viewModel.displayedAlbum
        
        nameLabel.text = displayedAlbum?.name
        
        if let imageUrl = displayedAlbum?.imageUrl,
            let url = URL(string: imageUrl)  {
            albumImage.af_setImage(withURL: url)
        }
    }
}

