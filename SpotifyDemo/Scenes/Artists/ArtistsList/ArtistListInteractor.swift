//
//  ArtistListInteractor.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol ArtistListBusinessLogic
{
    func fetchArtists(request: ArtistList.FetchArtists.Request)
    func selectArtistBy(index: Int)
}

protocol ArtistListDataStore
{
    var fetchedArtists: [Artist] { get set }
    var selectedArtist: Artist? { get set }
}

class ArtistListInteractor: ArtistListBusinessLogic, ArtistListDataStore
{
    var presenter: ArtistListPresentationLogic?
    var worker: ArtistListWorker?
    var fetchedArtists: [Artist] = []
    var selectedArtist: Artist?
    
    // MARK: Methods
    
    func selectArtistBy(index: Int) {
        selectedArtist = fetchedArtists[index]
    }
    
    func fetchArtists(request: ArtistList.FetchArtists.Request)
    {
        worker = ArtistListWorker()
        worker?.searchArtistsBy(name: request.artistName){ (fetchedArtists, error) in
            if let error = error {
                self.presenter?.showError(error: error)
                return
            }
            self.fetchedArtists = fetchedArtists
            let response = ArtistList.FetchArtists.Response(fetchedArtists: fetchedArtists)
            self.presenter?.presentArtists(response: response)
         }
    }
}
