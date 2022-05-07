//
//  EndPoint.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/4/22.
//

import Foundation

struct EndPoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension EndPoint {
    static func search(matching query: String,_ page: Int) -> EndPoint {
        return EndPoint(
            path: "/search",
            queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "media_type", value: "image"),
                URLQueryItem(name: "page", value: String(page))
            ]
        )
    }
}

extension EndPoint {
    // We still have to keep 'url' as an optional, since we're
    // dealing with dynamic components that could be invalid.
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "images-api.nasa.gov"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}


