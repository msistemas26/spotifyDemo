//
//  ArtistDetailsWorker.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

class ArtistDetailsWorker
{
    func fetchArtistAlbums(completionHandler completion: @escaping ([ArtistAlbum]) -> Void)
    {
        var fetchedArtistAlbums:[ArtistAlbum] = []
        for index in 1...50 {
            fetchedArtistAlbums.append(ArtistAlbum(description: "Demo \(index)"))
        }
        completion(fetchedArtistAlbums)
    }
}

struct ArtistAlbum
{
    var description: String?
}
