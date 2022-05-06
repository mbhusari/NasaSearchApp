//
//  EndPoint.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/4/22.
//

import Foundation

protocol EndPointProtocol {
    var baseUrl: String { get set}
    func urlRequest() -> URLRequest?
}


class EndPoint: EndPointProtocol {
    
    var baseUrl: String = searchUrl
    
    func urlRequest() -> URLRequest? {
        let urlRequest = URLRequest(url: URL(string: baseUrl)!, timeoutInterval: Double.infinity)
        return urlRequest
    }
}
