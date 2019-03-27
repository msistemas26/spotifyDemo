//
//  ArtistDetailsPresenter.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol ArtistDetailsPresentationLogic
{
    func presentArtistAlbums(response: ArtistDetails.FetchArtistAlbums.Response)
    func showError(error: ErrorResponse)
}

class ArtistDetailsPresenter: ArtistDetailsPresentationLogic
{
     weak var viewController: ArtistDetailsDisplayLogic?
  
     // MARK: Methods
  
     func presentArtistAlbums(response: ArtistDetails.FetchArtistAlbums.Response)
     {
     	var fetchedArtistAlbums: [ArtistDetails.FetchArtistAlbums.ViewModel.DisplayedArtistAlbum] = []
        for fetchedArtistAlbum in response.fetchedArtistAlbums
        {
            let availableMarket = fetchedArtistAlbum.availableMarkets?.joined(separator:", ")
            let displayedArtistAlbums = ArtistDetails.FetchArtistAlbums.ViewModel.DisplayedArtistAlbum(id: fetchedArtistAlbum.id, name: fetchedArtistAlbum.name, imageUrl: fetchedArtistAlbum.images?.first?.url,availableMarkets: availableMarket)
            
            fetchedArtistAlbums.append(displayedArtistAlbums)
        }
        let viewModel = ArtistDetails.FetchArtistAlbums.ViewModel(displayedArtistAlbums: fetchedArtistAlbums)
        viewController?.displayArtistAlbums(viewModel: viewModel)
     }
    
    func showError(error: ErrorResponse){
        viewController?.showError(message: error.message ?? ErrorResponseData.unknown)
    }
}
