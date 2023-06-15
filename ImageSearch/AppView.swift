//
//  AppView.swift
//  ImageSearch
//
//  Created by Robert Manson on 6/14/23.
//

import SearchResultsFeature
import SwiftUI

struct AppView: View {
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
        SearchResultsView()
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
