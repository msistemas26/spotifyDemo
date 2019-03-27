//
//  ArtistDetailsRouter.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol ArtistDetailsRoutingLogic
{
    func showSelectedArtistAlbum()
}

protocol ArtistDetailsDataPassing
{
    var dataStore: ArtistDetailsDataStore? { get set }
}

class ArtistDetailsRouter: NSObject, ArtistDetailsRoutingLogic, ArtistDetailsDataPassing
{
    weak var viewController: ArtistDetailsViewController?
    var dataStore: ArtistDetailsDataStore?
    
    // MARK: Routing
    
    func showSelectedArtistAlbum()
    {
        if (dataStore?.selectedArtist) != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "AlbumDetailsViewController") as! AlbumDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToAlbumDetails(source: dataStore!, destination: &destinationDS)
            navigateToAlbumDetails(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Passing data
    
    func passDataToAlbumDetails(source: ArtistDetailsDataStore, destination: inout AlbumDetailsDataStore)
    {
        if let selectedArtistAlbum = source.selectedArtistAlbum {
            destination.selectedAlbum = selectedArtistAlbum
        }
    }
    
    // MARK: Navigation
    
    func navigateToAlbumDetails(source: ArtistDetailsViewController, destination: AlbumDetailsViewController) {
        source.show(destination, sender: nil)
    }
}
