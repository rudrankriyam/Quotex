//
//  AddNewTagView.swift
//  Quotex
//
//  Created by Rudrank Riyam on 14/11/22.
//

import SwiftUI
import QuoteKit

struct AddNewTagView: View {
  @EnvironmentObject var viewModel: TagsViewModel
  @Environment(\.dismiss) private var dismiss

  @State private var name: String = ""
  @State private var error: String = ""

  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section(header: Text("TAG NAME")) {
            TextField("Tag name...", text: $name)
              .padding(.horizontal)

            if !error.isEmpty {
              Text(error)
                .foregroundColor(.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.red))
            }
          }
        }

        Button(action: { createTag() }, label: {
          Text("CREATE TAG")
            .kerning(1)
        })
        .buttonStyle(.borderedProminent)
      }
      .navigationTitle("New Tag")
    }
  }

  private func createTag() {
    if !name.isEmpty {
      do {
        try viewModel.createTag(for: name)
        dismiss()
      } catch ValidationError.containsNumbersOrSpecialCharacters(let errorMessage) {
        self.error = errorMessage
      } catch {
        self.error = error.localizedDescription
      }
    }
  }
}
