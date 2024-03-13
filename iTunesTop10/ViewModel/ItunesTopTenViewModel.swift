//
//  ItunesTopTenViewModel.swift
//  iTunesTop10
//
//  Created by Antonio Madrid on 12-03-24.
//

import Foundation

class ItunesTopTenViewModel: ObservableObject {
    
    private let itunesService: ItunesServiceProtocol
    
    var userFavoriteSongs: [Song] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "FavoriteSongs"),
                  let songs = try? JSONDecoder().decode([Song].self, from: data) else {
                return []
            }
            return songs
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "FavoriteSongs")
            }
        }
    }
    
    @Published var clSongs = [Song]()
    @Published var usSongs = [Song]()
    @Published var seSongs = [Song]()
    @Published var favoriteSongs = [Song]()
    @Published var selectedSong: Song?
    
    init(itunesService: ItunesServiceProtocol = ItunesService()) {
        self.itunesService = itunesService
        fetchTopSongs(country: "cl") { [weak self] songs in
            self?.clSongs = songs ?? []
        }
        fetchTopSongs(country: "us") { [weak self] songs in
            self?.usSongs = songs ?? []
        }
        fetchTopSongs(country: "se") { [weak self] songs in
            self?.seSongs = songs ?? []
        }
        self.favoriteSongs = self.userFavoriteSongs
    }
    
    private func fetchTopSongs(country: String, completion: @escaping ([Song]?) -> Void) {
        itunesService.fetchTopSongs(country: country) { [weak self] songs in
            DispatchQueue.main.async {
                completion(songs)
                if let songs = songs {
                    print("\(country) songs:")
                    for song in songs {
                        print(song.description)
                    }
                } else {
                    print("\(country) songs: No songs found")
                }
            }
        }
    }
    
    func toggleFavorite(song: Song) {
        if let index = favoriteSongs.firstIndex(where: { $0.id == song.id }) {
            favoriteSongs.remove(at: index)
        } else {
            favoriteSongs.append(song)
        }
        userFavoriteSongs = favoriteSongs
    }
    
    func isFavorite(song: Song) -> Bool {
        return favoriteSongs.contains(where: { $0.id == song.id })
    }
}
