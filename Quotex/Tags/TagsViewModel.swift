//
//  TagsViewModel.swift
//  Quotex
//
//  Created by Rudrank Riyam on 13/11/22.
//

import Foundation
import SwiftUI
import QuoteKit

@MainActor
class TagsViewModel: ObservableObject {
  @Published private(set) var tags: Tags = []
  @Published var selectedTag: Tag?
  @Published var quotes: [Quote] = []
  @Published var showAddTagsView = false

  public func getTags() {
    Task {
      do {
        tags = try await QuoteKit.tags()
      } catch {
        print(error)
      }
    }
  }

  public func selectTag(for tag: Tag) {
    selectedTag = tag
  }

  public func createTag(for name: String) throws {
    try validateTag(for: name)

    let id = UUID().uuidString
    let dateAdded = Date().formatted()
    let dateModified = Date().formatted()
    let quoteCount = 0

    let tag = Tag(id: id, name: name, dateAdded: dateAdded, dateModified: dateModified, quoteCount: quoteCount)

    tags.append(tag)
  }

  public func validateTag(for name: String) throws {
    let range = NSRange(location: 0, length: name.utf16.count)
    let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*")

    let match = regex.firstMatch(in: name, options: [], range: range)

    if match != nil {
      // Condition not met for the tag. Show an error.\
      let errorMessage = "\(name) contains numbers or special characters. Use only alphabets for the name of the tag."
      throw ValidationError.containsNumbersOrSpecialCharacters(errorMessage)
    }
  }

  public func getQuotes() {
    Task {
      do {
        if let selectedTag = selectedTag {
          quotes = try await QuoteKit.quotes(tags: [selectedTag.name]).results
        }
      } catch {
        print(error)
      }
    }
  }
}

enum ValidationError: Error {
  case containsNumbersOrSpecialCharacters(String)
}

public func validateTag(for name: String) throws {
  let range = NSRange(location: 0, length: name.utf16.count)
  let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*")

  let match = regex.firstMatch(in: name, options: [], range: range)

  if match != nil {
    // Condition not met for the tag. Show an error.\
    let errorMessage = "\(name) contains numbers or special characters. Use only alphabets for the name of the tag."
    throw ValidationError.containsNumbersOrSpecialCharacters(errorMessage)
  }
}
