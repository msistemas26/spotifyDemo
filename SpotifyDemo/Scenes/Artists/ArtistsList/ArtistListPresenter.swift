//
//  ArtistListPresenter.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol ArtistListPresentationLogic
{
     func presentArtists(response: ArtistList.FetchArtists.Response)
}

class ArtistListPresenter: ArtistListPresentationLogic
{
     weak var viewController: ArtistListDisplayLogic?
  
     // MARK: Methods
  
     func presentArtists(response: ArtistList.FetchArtists.Response)
     {
     	var fetchedArtists: [ArtistList.FetchArtists.ViewModel.DisplayedArtist] = []
        for fetchedArtist in response.fetchedArtists
        {
            let displayedArtists = ArtistList.FetchArtists.ViewModel.DisplayedArtist(id: fetchedArtist.id, name: fetchedArtist.name, popularity: fetchedArtist.popularity ?? 0, followers: fetchedArtist.followers?.total ?? 0, imageUrl: fetchedArtist.images?.first?.url)
            
            fetchedArtists.append(displayedArtists)
        }
        let viewModel = ArtistList.FetchArtists.ViewModel(displayedArtists: fetchedArtists)
        viewController?.displayArtists(viewModel: viewModel)
     }
}
