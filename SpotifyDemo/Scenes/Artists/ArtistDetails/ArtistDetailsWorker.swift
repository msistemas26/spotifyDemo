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
    let dataProviderApi = DataProviderApi()
    
    func searchAlbumsBy(artistId: String, completionHandler completion: @escaping ([Album], ErrorResponse?) -> Void)
    {
        dataProviderApi.searchAlbumsBy(artistId: artistId) { (albums, error) in
            completion(albums, error)
        }
    }
}
