//
//  AlbumDetailsModels.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 27/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

enum AlbumDetails
{
    // MARK: Use cases
    enum FetchAlbums
    {
        struct Request
        {
        }
        struct Response
        {
            var fetchedAlbums: [Album]
        }
        struct ViewModel
        {
            struct DisplayedAlbum
            {
                var description: String?
            }
            var displayedAlbums: [DisplayedAlbum]
        }
    }
}