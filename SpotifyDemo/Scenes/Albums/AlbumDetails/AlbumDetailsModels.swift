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
            var fetchedAlbum: Album
        }
        struct ViewModel
        {
            struct DisplayedAlbum
            {
                let id: String
                let name: String?
                let imageUrl: String?
                let externalUrl: String?
            }
            var displayedAlbum: DisplayedAlbum
        }
    }
}
