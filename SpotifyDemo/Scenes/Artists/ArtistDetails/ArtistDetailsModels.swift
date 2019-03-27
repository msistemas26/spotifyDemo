//
//  ArtistDetailsModels.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

enum ArtistDetails
{
    // MARK: Use cases
    enum FetchArtistAlbums
    {
        struct Request
        {
        }
        struct Response
        {
            var fetchedArtistAlbums: [ArtistAlbum]
        }
        struct ViewModel
        {
            struct DisplayedArtistAlbum
            {
                var description: String?
            }
            var displayedArtistAlbums: [DisplayedArtistAlbum]
        }
    }
}