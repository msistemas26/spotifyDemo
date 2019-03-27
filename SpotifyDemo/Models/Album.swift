//
//  Album.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright © 2019 Raul Mantilla Assia. All rights reserved.
//

import Foundation

struct Album: Codable {
    let albumGroup: String
    let albumType: String?
    let externalUrls: ExternalUrl?
    let href: String?
    let id: String
    let images: [Image]?
    let name: String?
    let releaseDate: String?
    let releaseDatePrecision: String?
    let totalTracks: Int?
    let type: String?
    let uri: String?
    let availableMarkets: [String]?
    let artists: [Artist]
    
    enum CodingKeys: String, CodingKey {
        case albumGroup = "album_group"
        case albumType = "album_type"
        case externalUrls = "external_urls"
        case href
        case id
        case images
        case name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case type
        case uri
        case artists
    }
}

struct AlbumsResponse: Codable {
    let href: String?
    let items: [Album]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
}

