//
//  itunesService.swift
//  iTunesTop10
//
//  Created by Antonio Madrid on 12-03-24.
//

import Foundation

struct ResponseData: Decodable {
    let results: [Song]
}

enum ItunesServiceError: Error {
    case urlError
    case networkError(Error)
    case decodingError(Error)
}

protocol ItunesServiceProtocol {
    func fetchTopSongs(country: String, completion: @escaping (Result<[Song], ItunesServiceError>) -> Void)
}

class ItunesService: ItunesServiceProtocol {
    func fetchTopSongs(country: String, completion: @escaping (Result<[Song], ItunesServiceError>) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=pop&country=\(country)&entity=song&limit=10"
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let data = data else { return }

            do {
                let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                completion(.success(responseData.results))
            } catch let decodeError {
                completion(.failure(.decodingError(decodeError)))
            }
        }.resume()
    }
}
