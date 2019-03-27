//
//  AlbumDetailsPresenter.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 27/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

protocol AlbumDetailsPresentationLogic
{
     func presentAlbum(response: AlbumDetails.FetchAlbums.Response)
}

class AlbumDetailsPresenter: AlbumDetailsPresentationLogic
{
     weak var viewController: AlbumDetailsDisplayLogic?
  
     // MARK: Methods
  
     func presentAlbum(response: AlbumDetails.FetchAlbums.Response)
     {
        let fetchedAlbum = response.fetchedAlbum
        let displayedAlbum = AlbumDetails.FetchAlbums.ViewModel.DisplayedAlbum(id: fetchedAlbum.id, name: fetchedAlbum.name, imageUrl: fetchedAlbum.images?.first?.url, externalUrl: fetchedAlbum.externalUrls?.spotify)
        let viewModel = AlbumDetails.FetchAlbums.ViewModel(displayedAlbum: displayedAlbum)
        viewController?.displayAlbum(viewModel: viewModel)
     }
}
