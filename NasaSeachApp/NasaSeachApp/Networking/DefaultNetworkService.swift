//
//  DefaultNetworkService.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/5/22.
//

import Foundation

enum NetworkServiceError: Error {
    case urlRegeneration
    case parsing(Error)
    case noData
}

protocol NetworkServiceProtocol {
    func fetchSearchData(with endPoint: EndPoint, completon: @escaping ((Result<[Item], NetworkServiceError>) -> Void )) -> Cancellable?
}


class DefaultNetworkService: NetworkServiceProtocol {
    func fetchSearchData(with endPoint: EndPoint, completon: @escaping ((Result<[Item], NetworkServiceError>) -> Void )) -> Cancellable? {
        
        guard let url = endPoint.urlRequest() else {
            completon(.failure(.urlRegeneration))
            return nil
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completon(.failure(.noData))
                semaphore.signal()
                return
            }
            
            do {
                let result: Welcome = try JSONDecoder().decode(Welcome.self, from: data)
                completon(.success(result.collection.items))
            } catch let err {
                print(err)
                completon(.failure(.parsing(err)))
            }
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        return task
        
    }
    
    
}

extension URLSessionTask: Cancellable {}

