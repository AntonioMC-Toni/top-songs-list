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
                if viewModel.clSongs.isEmpty{
                    Text("No se han encontrado canciones para Chile")
                        .foregroundStyle(.red)
                }
            }

            Section(header: Text("Top 10 canciones de EEUU").font(.headline)) {
                ForEach(viewModel.usSongs) { song in
                    songRow(song: song)
                }
                if viewModel.usSongs.isEmpty{
                    Text("No se han encontrado canciones para EEUU")
                        .foregroundStyle(.red)
                }
            }

            Section(header: Text("Top 10 canciones de Suecia").font(.headline)) {
                ForEach(viewModel.seSongs) { song in
                    songRow(song: song)
                }
                if viewModel.seSongs.isEmpty{
                    Text("No se han encontrado canciones para Suecia")
                        .foregroundStyle(.red)
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

