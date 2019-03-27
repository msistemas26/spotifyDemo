//
//  ArtistDetailsInteractor.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol ArtistDetailsBusinessLogic
{
    func fetchArtistAlbums(request: ArtistDetails.FetchArtistAlbums.Request)
}

protocol ArtistDetailsDataStore
{
    var fetchedArtistAlbums: [ArtistAlbum] { get set }
    var selectedArtistAlbum: ArtistAlbum? { get set }
}

class ArtistDetailsInteractor: ArtistDetailsBusinessLogic, ArtistDetailsDataStore
{
    var presenter: ArtistDetailsPresentationLogic?
    var worker: ArtistDetailsWorker?
    var fetchedArtistAlbums: [ArtistAlbum] = []
    var selectedArtistAlbum: ArtistAlbum?
    
    // MARK: Methods
    
    func fetchArtistAlbums(request: ArtistDetails.FetchArtistAlbums.Request)
    {
         worker = ArtistDetailsWorker()
         worker?.fetchArtistAlbums{ (fetchedArtistAlbums) in
            self.fetchedArtistAlbums = fetchedArtistAlbums
            let response = ArtistDetails.FetchArtistAlbums.Response(fetchedArtistAlbums: fetchedArtistAlbums)
            self.presenter?.presentArtistAlbums(response: response)
         }
    }
}
