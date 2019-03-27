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
    func fetchAlbums(request: AlbumDetails.FetchAlbums.Request)
}

protocol AlbumDetailsDataStore
{
    var fetchedAlbums: [Album] { get set }
    var selectedAlbum: Album? { get set }
}

class AlbumDetailsInteractor: AlbumDetailsBusinessLogic, AlbumDetailsDataStore
{
    var presenter: AlbumDetailsPresentationLogic?
    var worker: AlbumDetailsWorker?
    var fetchedAlbums: [Album] = []
    var selectedAlbum: Album?
    
    // MARK: Methods
    
    func fetchAlbums(request: AlbumDetails.FetchAlbums.Request)
    {
         worker = AlbumDetailsWorker()
         worker?.fetchAlbums{ (fetchedAlbums) in
            self.fetchedAlbums = fetchedAlbums
            let response = AlbumDetails.FetchAlbums.Response(fetchedAlbums: fetchedAlbums)
            self.presenter?.presentAlbums(response: response)
         }
    }
}
