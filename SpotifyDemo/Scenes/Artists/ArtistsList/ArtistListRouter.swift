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
    func showSelectedArtist(withArtistIndex: Int)
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
    
    func showSelectedArtist(withArtistIndex: Int)
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
    
    func navigateToConversation(source: ArtistListViewController, destination: ViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToConversation(source: ArtistListDataStore, destination: inout DataStore)
    {
        destination.value = ""
    }
    */
}
