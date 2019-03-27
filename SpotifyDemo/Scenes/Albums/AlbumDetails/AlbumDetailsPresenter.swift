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
     func presentAlbums(response: AlbumDetails.FetchAlbums.Response)
}

class AlbumDetailsPresenter: AlbumDetailsPresentationLogic
{
     weak var viewController: AlbumDetailsDisplayLogic?
  
     // MARK: Methods
  
     func presentAlbums(response: AlbumDetails.FetchAlbums.Response)
     {
     	var fetchedAlbums: [AlbumDetails.FetchAlbums.ViewModel.DisplayedAlbum] = []
        for fetchedAlbum in response.fetchedAlbums
        {
            let displayedAlbums = AlbumDetails.FetchAlbums.ViewModel.DisplayedAlbum(description: fetchedAlbum.description)
            
            fetchedAlbums.append(displayedAlbums)
        }
        let viewModel = AlbumDetails.FetchAlbums.ViewModel(displayedAlbums: fetchedAlbums)
        viewController?.displayAlbums(viewModel: viewModel)
     }
}
