//
//  ContentView.swift
//  Quotex
//
//  Created by Rudrank Riyam on 29/09/22.
//

import SwiftUI
import QuoteKit

struct ContentView: View {

  var body: some View {
    NavigationView {
      TabView {
        RandomQuoteView()
          .tabItem({ Label("Quote", systemImage: "quote.closing") })
        
        TagsView()
          .tabItem({ Label("Tags", systemImage: "tag") })
      }
      .navigationTitle("Quotex")
    }
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
