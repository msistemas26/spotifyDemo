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
    func showSelectedArtistAlbum(withArtistAlbumIndex: Int)
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
    
    func showSelectedArtistAlbum(withArtistAlbumIndex: Int)
    {
        /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToConversation(source: dataStore!, destination: &destinationDS)
        navigateToConversation(source: viewController!, destination: destinationVC)
         */
    }
    
    /*
    // MARK: Navigation
    
    func navigateToConversation(source: ArtistDetailsViewController, destination: ViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToConversation(source: ArtistDetailsDataStore, destination: inout DataStore)
    {
        destination.value = ""
    }
    */
}
