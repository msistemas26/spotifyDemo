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
    func getArtistName() -> String
    func selectAlbumBy(index: Int)
}

protocol ArtistDetailsDataStore
{
    var fetchedArtistAlbums: [Album] { get set }
    var selectedArtistAlbum: Album? { get set }
    var selectedArtist: Artist? { get set }
}

class ArtistDetailsInteractor: ArtistDetailsBusinessLogic, ArtistDetailsDataStore
{
    var presenter: ArtistDetailsPresentationLogic?
    var worker: ArtistDetailsWorker?
    var fetchedArtistAlbums: [Album] = []
    var selectedArtistAlbum: Album?
    var selectedArtist: Artist?
    
    // MARK: Methods
    
    func getArtistName() -> String {
        return selectedArtist?.name ?? "Albums"
    }
    
    func selectAlbumBy(index: Int) {
        selectedArtistAlbum = fetchedArtistAlbums[index]
    }
    
    func fetchArtistAlbums(request: ArtistDetails.FetchArtistAlbums.Request)
    {
        if let selectedArtistId = selectedArtist?.id {
            worker = ArtistDetailsWorker()
            worker?.searchAlbumsBy(artistId: selectedArtistId){ (fetchedArtistAlbums, error) in
                if let error = error {
                    self.presenter?.showError(error: error)
                    return
                }
                self.fetchedArtistAlbums = fetchedArtistAlbums
                let response = ArtistDetails.FetchArtistAlbums.Response(fetchedArtistAlbums: fetchedArtistAlbums)
                self.presenter?.presentArtistAlbums(response: response)
            }
        }
    }
}
