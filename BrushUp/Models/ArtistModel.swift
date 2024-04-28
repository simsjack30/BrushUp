//
//  ArtistModel.swift
//  BrushUp
//
//  Created by John Sims on 4/27/24.
//

import Foundation

struct ArtworkResponse: Decodable {
    let data: [ArtworkData]
    let config: ArtworkConfig?
}

struct ArtworkData: Decodable {
    let artistTitle: String
    let imageId: String
    let title: String

    
    enum CodingKeys: String, CodingKey {
        case artistTitle = "artist_title"
        case imageId = "image_id"
        case title

    }
}

struct ArtworkConfig: Decodable {
    let iiifUrl: String
    
    enum CodingKeys: String, CodingKey {
        case iiifUrl = "iiif_url"
    }
}

struct Artist {
    var name: String
}


