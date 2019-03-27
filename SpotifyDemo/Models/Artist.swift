//
//  Artist.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright © 2019 Raul Mantilla Assia. All rights reserved.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String?
    let popularity: Int?
    let type: String?
    let uri: String?
    let externalUrls: ExternalUrl?
    let followers: Follower?
    let genres: [String]?
    let href: String?
    let images: [Image]?
    
    struct Follower: Codable {
        let href: String?
        let total: Int?
        enum CodingKeys: String, CodingKey {
            case href
            case total
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case externalUrls = "external_urls"
        case followers
        case genres
        case href
        case type
        case popularity
        case uri
        case images
    }
}

struct ArtistsResponse: Codable {
    let artists: Artists?
    
    struct Artists: Codable {
        let href: String?
        let items: [Artist]?
        let limit: Int?
        let next: String?
        let offset: Int?
        let previous: String?
        let total: Int?
    }
}

struct ExternalUrl: Codable {
    let spotify: String?
    enum CodingKeys: String, CodingKey {
        case spotify
    }
}

struct Image: Codable {
    let url: String?
    let height: Int?
    let width: Int?
    enum CodingKeys: String, CodingKey {
        case url
        case height
        case width
    }
}

