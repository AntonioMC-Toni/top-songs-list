//
//  ContentView.swift
//  iTunesTop10
//
//  Created by Antonio Madrid on 12-03-24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var itunesViewModel = ItunesTopTenViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            SongListView(viewModel: itunesViewModel)
            Divider()
            NavigationLink(destination: FavoriteSongsView(viewModel: itunesViewModel)) {
                HStack{
                    Image(systemName: "heart.fill")
                    Text("Show Favorite Songs")
                        .font(.title)
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    ContentView()
}
