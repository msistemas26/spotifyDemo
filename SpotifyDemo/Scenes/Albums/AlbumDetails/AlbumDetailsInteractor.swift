//
//  AlbumDetailsInteractor.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 27/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol AlbumDetailsBusinessLogic
{
    func fetchAlbum()
}

protocol AlbumDetailsDataStore
{
    var selectedAlbum: Album? { get set }
}

class AlbumDetailsInteractor: AlbumDetailsBusinessLogic, AlbumDetailsDataStore
{
    var presenter: AlbumDetailsPresentationLogic?
    var selectedAlbum: Album?
    
    // MARK: Methods
    
    func fetchAlbum()
    {
        if let fetchedAlbums = selectedAlbum {
            let response = AlbumDetails.FetchAlbums.Response(fetchedAlbum: fetchedAlbums)
            self.presenter?.presentAlbum(response: response)
        }
    }
}
