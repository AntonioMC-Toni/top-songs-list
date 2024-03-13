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

protocol ItunesServiceProtocol {
    func fetchTopSongs(country: String, completion: @escaping ([Song]?) -> Void)
}

class ItunesService: ItunesServiceProtocol {
    func fetchTopSongs(country: String, completion: @escaping ([Song]?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=pop&country=\(country)&entity=song&limit=10"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch data with error: ", error)
                completion(nil)
                return
            }

            guard let data = data else { return }

            do {
                let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                completion(responseData.results)
            } catch let decodeError {
                print("Failed to decode data: ", decodeError)
                completion(nil)
            }
        }.resume()
    }
}
