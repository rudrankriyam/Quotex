//
//  TagsDetailView.swift
//  Quotex
//
//  Created by Rudrank Riyam on 13/11/22.
//

import SwiftUI
import QuoteKit

struct TagDetailView: View {
  @EnvironmentObject var viewModel: TagsViewModel

  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.quotes) { quote in
          Text(quote.content)
            .padding(.vertical, 4)
        }
      }
      .navigationTitle(viewModel.selectedTag?.capitalisedName ?? "")
    }
    .task {
      viewModel.getQuotes()
    }
  }
}
