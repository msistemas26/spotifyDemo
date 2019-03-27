//
//  ArtistListWorker.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright (c) 2019 Raul Mantilla Assia. All rights reserved.
//

import UIKit

class ArtistListWorker
{
    let dataProviderApi = DataProviderApi()
    
    func searchArtistsBy(name: String?, completionHandler completion: @escaping ([Artist],ErrorResponse?) -> Void)
    {
        dataProviderApi.searchArtistsBy(name: name) { (artists, error) in
            completion(artists, error)
        }
    }
}
