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
            var artistId: String?
        }
        struct Response
        {
            var fetchedArtistAlbums: [Album]
        }
        struct ViewModel
        {
            struct DisplayedArtistAlbum
            {
                let id: String
                let name: String?
                let imageUrl: String?
                let availableMarkets: String?
            }
            var displayedArtistAlbums: [DisplayedArtistAlbum]
        }
    }
}
