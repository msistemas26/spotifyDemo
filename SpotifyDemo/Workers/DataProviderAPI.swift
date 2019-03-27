//
//  DataProviderAPI.swift
//  SpotifyDemo
//
//  Created by Raul Mantilla on 26/03/19.
//  Copyright © 2019 Raul Mantilla Assia. All rights reserved.
//

import Foundation
import Alamofire

enum API
{
    static let path = "https://api.spotify.com/v1/"
    static let token = "Bearer BQBjuBF6KNmISUESTh3J-yPk_lyGTNxH3t-trRLibbAUp-t7PB03ozjw4r_ffYP0KG_3KehfoGApsFgCL85jl31w3AgiTt4uWz42Ct0Xu2bHPYI-1UDH5BcgMtr1-zPVg-85FI986RF-6XODsXYSF1Q"
}

enum Endpoint
{
    static let search = "search"
    static let albums = "artists/{id}/albums"
}

enum params
{
    static let type = "type"
    static let q = "q"
    static let market = "market"
    static let limit = "limit"
    static let offset = "offset"
    static let includeGroups = "include_groups"
}

final class DataProviderApi
{
    
    init()
    {
        //TO DO
    }
    
    func searchArtistsBy(name: String?, completionHandler completion: @escaping ([Artist], Error?) -> Void)
    {
        guard let nameString = name, !nameString.isEmpty,
            let qName = nameString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                completion([],nil)
                return
        }
        
        let urlString = API.path + Endpoint.search + "?\(params.q)=\(qName)&\(params.type)=artist&\(params.market)=US&\(params.limit)=10&\(params.offset)=5"
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "\(API.token)"
        ]
        Alamofire
            .request(urlString,
                     method: .get,
                     headers: headers)
            .responseJSON { response in
                guard let jsonData = response.data else {
                    completion([],nil)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let artistsResponse = try decoder.decode(ArtistsResponse.self, from:
                        jsonData)
                    completion(artistsResponse.artists?.items ?? [], nil)
                } catch let parsingError {
                    print("Error", parsingError)
                    completion([],parsingError)
                }
        }
    }
    
    func searchAlbumsBy(artistId: String, completionHandler completion: @escaping ([Album],Error?) -> Void)
    {
        let urlString = API.path + Endpoint.albums + "?\(params.includeGroups)=single%2Cappears_on&\(params.market)=US&\(params.limit)=10&\(params.offset)=5"
        
        let urlAlbumsString = urlString.replacingOccurrences(of: "{id}", with: artistId)
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "\(API.token)"
        ]
        Alamofire
            .request(urlAlbumsString,
                     method: .get,
                     headers: headers)
            .responseJSON { response in
                guard let jsonData = response.data else {
                    completion([],nil)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let alabumsResponse = try decoder.decode(AlbumsResponse.self, from:
                        jsonData)
                    completion(alabumsResponse.items ?? [],nil)
                } catch let parsingError {
                    print("Error", parsingError)
                    completion([],parsingError)
                }
        }
    }
}
