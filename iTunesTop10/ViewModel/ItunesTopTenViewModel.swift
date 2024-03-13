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
        fetchTopSongs(country: "cl")
        fetchTopSongs(country: "us")
        fetchTopSongs(country: "se")
        self.favoriteSongs = self.userFavoriteSongs
    }
    
    @Published var error: String?
    
    private func fetchTopSongs(country: String) {
        itunesService.fetchTopSongs(country: country) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let songs):
                    print("\(country) songs:")
                    for song in songs {
                        print(song.description)
                    }
                    if country == "cl" {
                        self?.clSongs = songs
                    } else if country == "us" {
                        self?.usSongs = songs
                    } else if country == "se" {
                        self?.seSongs = songs
                    }
                case .failure(let error):
                    switch error {
                    case .urlError:
                        self?.error = "Ha habido un error al hacer la petición al servidor de iTunes"
                    case .networkError:
                        self?.error = "Ha habido un error de red. Intente nuevamente"
                    case .decodingError:
                        self?.error = "Ha habido un error con la aplicación. Itente nuevamente"
                    }
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
