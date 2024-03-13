//
//  Song.swift
//  iTunesTop10
//
//  Created by Antonio Madrid on 12-03-24.
//

import Foundation

class Song: Decodable, Identifiable, Encodable {
    let id: Int
    let artworkUrl100: String
    let artistName: String
    let collectionName: String
    let trackName: String
    
    var description: String {
        return "Track: \(trackName), Artist: \(artistName)"
    }

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case artworkUrl100
        case artistName
        case collectionName
        case trackName
    }
}

