//
//  ImageSearchModel.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/4/22.
//
import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let collection: Collection
}

// MARK: - Collection
struct Collection: Codable {
    let version: String
    let href: String
    let items: [Item]
    let metadata: Metadata?
    let links: [CollectionLink]?
}

// MARK: - Item
struct Item: Codable {
    let href: String
    let data: [Datum]
    let links: [ItemLink]
}

// MARK: - Datum
struct Datum: Codable {
    let datumDescription, title: String
    let photographer: String?
    let keywords: [String]?
    let location: String?
    let nasaID: String
    let mediaType: MediaType
    let dateCreated: String?
    let center: String?
    let description508, secondaryCreator: String?

    enum CodingKeys: String, CodingKey {
        case datumDescription = "description"
        case title, photographer, keywords, location
        case nasaID = "nasa_id"
        case mediaType = "media_type"
        case dateCreated = "date_created"
        case center
        case description508 = "description_508"
        case secondaryCreator = "secondary_creator"
    }
}

enum MediaType: String, Codable {
    case image = "image"
}

// MARK: - ItemLink
struct ItemLink: Codable {
    let href: String
    let rel: Rel
    let render: MediaType
}

enum Rel: String, Codable {
    case preview = "preview"
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
    let rel, prompt: String
    let href: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let totalHits: Int

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}
