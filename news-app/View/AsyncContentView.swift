//
//  AsyncContentView.swift
//  news-app
//
//  Created by jaerka on 16.04.23.
//

import Foundation

struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content
    
    init(source: Source,
           @ViewBuilder content: @escaping (Source.Output) -> Content) {
          self.source = source
          self.content = content
      }
      

    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error, retryHandler: source.load)
        case .loaded(let output):
            content(output)
        }
    }

    extension AsyncContentView {
        init<P: Publisher>(
            source: P,
            @ViewBuilder content: @escaping (P.Output) -> Content
        ) where Source == PublishedObject<P> {
            self.init(
                source: PublishedObject(publisher: source),
                content: content
            )
        }
    }
