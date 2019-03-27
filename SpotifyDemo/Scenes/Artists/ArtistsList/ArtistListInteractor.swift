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
    //func filterArtistBy(artistName: String?)
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
    
    func fetchArtists(request: ArtistList.FetchArtists.Request)
    {
        worker = ArtistListWorker()
        worker?.searchArtistsBy(name: request.artistName){ (fetchedArtists) in
            self.fetchedArtists = fetchedArtists
            let response = ArtistList.FetchArtists.Response(fetchedArtists: fetchedArtists)
            self.presenter?.presentArtists(response: response)
         }
    }
//
//    func filterArtistBy(artistName: String?)
//    {
//        guard let artistName = artistName?.uppercased(), !artistName.isEmpty  else {
//            let response = ArtistList.FetchArtists.Response(fetchedArtists: self.fetchedArtists)
//            self.presenter?.presentArtists(response: response)
//            return
//        }
//
//        let filteredArtists = fetchedArtists.filter{
//            if let name = $0.name?.uppercased() {
//                return name.contains(artistName)
//            } else {
//                return false
//            }
//        }
//        let response = ArtistList.FetchArtists.Response(fetchedArtists: filteredArtists)
//        self.presenter?.presentArtists(response: response)
//    }
}
