//
//  TagsView.swift
//  Quotex
//
//  Created by Rudrank Riyam on 02/10/22.
//

import SwiftUI
import QuoteKit

struct TagsView: View {
  @StateObject private var viewModel = TagsViewModel()

  var body: some View {
    ScrollView {
      FlowLayout(viewModel.tags) { tag in
        Button(action: {
          viewModel.selectTag(for: tag)
        }, label: {
          Text(tag.name)
            .bold()
            .foregroundColor(.black)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1.5))
        })
      }
      .padding()
    }

    .sheet(item: $viewModel.selectedTag, onDismiss: {
      viewModel.quotes = []
    }) { _ in
      TagDetailView()
        .environmentObject(viewModel)
    }
    .sheet(isPresented: $viewModel.showAddTagsView) {
      AddNewTagView().environmentObject(viewModel)
    }

    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          viewModel.showAddTagsView.toggle()
        }, label: {
          Image(systemName: "plus")
        })
      }
    }
    .task {
      viewModel.getTags()
    }
  }
}

struct TagsView_Previews: PreviewProvider {
  static var previews: some View {
    TagsView()
  }
}

