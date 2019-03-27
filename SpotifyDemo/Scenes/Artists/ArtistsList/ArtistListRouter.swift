//
//  ArtistListRouter.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol ArtistListRoutingLogic
{
    func showSelectedArtist()
}

protocol ArtistListDataPassing
{
    var dataStore: ArtistListDataStore? { get set }
}

class ArtistListRouter: NSObject, ArtistListRoutingLogic, ArtistListDataPassing
{
    weak var viewController: ArtistListViewController?
    var dataStore: ArtistListDataStore?
    
    // MARK: Routing
    
    func showSelectedArtist()
    {
        if (dataStore?.selectedArtist) != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "ArtistDetailsViewController") as! ArtistDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToArtistDetails(source: dataStore!, destination: &destinationDS)
            navigateToArtistDetails(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Passing data
    
    func passDataToArtistDetails(source: ArtistListDataStore, destination: inout ArtistDetailsDataStore)
    {
        if let selectedArtist = source.selectedArtist {
            destination.selectedArtist = selectedArtist
        }
    }
    
    // MARK: Navigation
    
    func navigateToArtistDetails(source: ArtistListViewController, destination: ArtistDetailsViewController)
    {
        source.show(destination, sender: nil)
    }
}
