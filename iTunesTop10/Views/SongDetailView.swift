//
//  SongDetailView.swift
//  iTunesTop10
//
//  Created by Antonio Madrid on 12-03-24.
//

import SwiftUI

struct SongDetailView: View {
    @ObservedObject var viewModel: ItunesTopTenViewModel
    var song: Song
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: song.artworkUrl100)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 200)
            } placeholder: {
                ProgressView()
            }
            
            Label1("Canción")
            Label2(song.trackName)
            Label1("Álbum")
            Label2(song.collectionName)
            Label1("Artista")
            Label2(song.artistName)
            
            Button(action: {
                viewModel.toggleFavorite(song: song)
            }) {
                Image(systemName: viewModel.isFavorite(song: song) ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            
        }
        .padding()
    }
    
    private func Label1(_ text: String) -> some View {
        Text(text)
            .font(.title2)
    }
    private func Label2(_ text: String) -> some View {
        Text(text)
            .font(.title)
    }
}

