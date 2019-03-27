//
//  AlbumDetailsRouter.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 27/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol AlbumDetailsRoutingLogic
{
    func showSelectedAlbum(withAlbumIndex: Int)
}

protocol AlbumDetailsDataPassing
{
    var dataStore: AlbumDetailsDataStore? { get set }
}

class AlbumDetailsRouter: NSObject, AlbumDetailsRoutingLogic, AlbumDetailsDataPassing
{
    weak var viewController: AlbumDetailsViewController?
    var dataStore: AlbumDetailsDataStore?
    
    // MARK: Routing
    
    func showSelectedAlbum(withAlbumIndex: Int)
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
    
    func navigateToConversation(source: AlbumDetailsViewController, destination: ViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToConversation(source: AlbumDetailsDataStore, destination: inout DataStore)
    {
        destination.value = ""
    }
    */
}
