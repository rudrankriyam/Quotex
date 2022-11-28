//
//  RandomQuoteView.swift
//  Quotex
//
//  Created by Rudrank Riyam on 13/11/22.
//

import SwiftUI
import QuoteKit

struct RandomQuoteView: View {
  @State private var randomQuote: Quote?

  var body: some View {
    VStack(spacing: 16) {
      Text(randomQuote?.content ?? "")
        .bold()
        .multilineTextAlignment(.center)
        .font(.title)

      Text(randomQuote?.author ?? "")
        .multilineTextAlignment(.center)
    }
    .padding()
    .task {
      randomQuote = try? await QuoteKit.randomQuote()
    }
  }
}
