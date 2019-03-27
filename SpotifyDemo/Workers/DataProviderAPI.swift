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
    static let token = "Bearer BQBWkfMzFkihld0ujnVuUO8qUNVb4lNvndsei6dZD2ST4Eyd-EnjIePgJxTxMA-6gYJolawccImMK_w_wOIvrI3qQqsedV2U9ckXC2W1g0u6HGdfX3kLDME3ijs1DQX6qlDST2khS-QShRopT4tgXF0"
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

struct ErrorResponseData: Codable {
    let error: ErrorResponse?
    static let unknown = "Unknown errror!"
}
struct ErrorResponse: Codable {
    let message: String?
    let status: Int?
}

final class DataProviderApi
{
    
    init()
    {
        //TO DO
    }
    
    func searchArtistsBy(name: String?, completionHandler completion: @escaping ([Artist], ErrorResponse?) -> Void)
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
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                guard let jsonData = response.data else {
                    completion([],nil)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    switch response.result{
                    case .success( _ as [String:Any]):
                        let artistsResponse = try decoder.decode(ArtistsResponse.self, from:
                            jsonData)
                        completion(artistsResponse.artists?.items ?? [], nil)
                    case .failure( _):
                        let errorResponse = try decoder.decode(ErrorResponseData.self, from:
                            jsonData)
                        completion([], errorResponse.error)
                    default:
                        completion([],ErrorResponse(message: ErrorResponseData.unknown, status: 500))
                    }
                } catch let parsingError {
                    print("Error", parsingError)
                    completion([],ErrorResponse(message: ErrorResponseData.unknown, status: 500))
                }
        }
    }
    
    func searchAlbumsBy(artistId: String, completionHandler completion: @escaping ([Album],ErrorResponse?) -> Void)
    {
        let urlString = API.path + Endpoint.albums + "?\(params.includeGroups)=single%2Cappears_on&\(params.limit)=10&\(params.offset)=5"
        
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
                    switch response.result{
                    case .success( _ as [String:Any]):
                        let alabumsResponse = try decoder.decode(AlbumsResponse.self, from:
                            jsonData)
                        completion(alabumsResponse.items ?? [], nil)
                    case .failure( _):
                        let errorResponse = try decoder.decode(ErrorResponseData.self, from:
                            jsonData)
                        completion([], errorResponse.error)
                    default:
                        completion([],ErrorResponse(message: ErrorResponseData.unknown, status: 500))
                    }
                } catch let parsingError {
                    print("Error", parsingError)
                    completion([],ErrorResponse(message: ErrorResponseData.unknown, status: 500))
                }
        }
    }
}
