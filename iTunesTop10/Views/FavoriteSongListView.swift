//
//  FavoriteSongListView.swift
//  iTunesTop10
//
//  Created by Antonio Madrid on 13-03-24.
//
import SwiftUI

struct FavoriteSongsView: View {
    @ObservedObject var viewModel: ItunesTopTenViewModel

    var body: some View {
        List {
            Section(header: Text("Favorite Songs").font(.headline)) {
                ForEach(viewModel.favoriteSongs) { song in
                    songRow(song: song)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .sheet(item: $viewModel.selectedSong) { song in
            SongDetailView(viewModel: viewModel, song: song)
        }
    }
    
    private func songRow(song: Song) -> some View {
        Button(action: {
            viewModel.selectedSong = song
        }) {
            HStack {
                Image(systemName: "music.note")
                Text(song.trackName)
            }
        }
    }
}
