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
    func openSpotify()
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
    
    func openSpotify()
    {
        if let link = dataStore?.selectedAlbum?.externalUrls?.spotify,
            let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
