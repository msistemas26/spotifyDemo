//
//  ArtistListModels.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

enum ArtistList
{
    // MARK: Use cases
    enum FetchArtists
    {
        struct Request
        {
             var artistName: String?
        }
        struct Response
        {
            var fetchedArtists: [Artist]
        }
        struct ViewModel
        {
            struct DisplayedArtist
            {
                let id: String
                let name: String?
                let popularity: Int
                let followers: Int
                let imageUrl: String?
            }
            var displayedArtists: [DisplayedArtist]
        }
    }
}
