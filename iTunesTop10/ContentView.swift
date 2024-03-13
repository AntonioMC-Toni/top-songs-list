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
        }
    }
}

#Preview {
    ContentView()
}
