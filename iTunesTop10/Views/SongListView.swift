//
//  SongListView.swift
//  iTunesTop10
//
//  Created by Antonio Madrid on 12-03-24.
//

import SwiftUI

struct SongListView: View {
    @ObservedObject var viewModel: ItunesTopTenViewModel

    var body: some View {
        List {
            Section(header: Text("Top 10 canciones de Chile").font(.headline)) {
                ForEach(viewModel.clSongs) { song in
                    songRow(song: song)
                }
            }

            Section(header: Text("Top 10 canciones de US").font(.headline)) {
                ForEach(viewModel.usSongs) { song in
                    songRow(song: song)
                }
            }

            Section(header: Text("Top 10 canciones de Suecia").font(.headline)) {
                ForEach(viewModel.seSongs) { song in
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

#Preview {
    SongListView(viewModel: ItunesTopTenViewModel())
}
