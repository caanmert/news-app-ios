//
//  ArticleListViewModel.swift
//  news-app
//
//  Created by jaerka on 16.04.23.
//

import Foundation
import Combine

class ArticleListViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var isError = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func getArticles() {
        isLoading = true
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=YOUR_API_KEY") else {
            isLoading = false
            isError = true
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure:
                    self?.isError = true
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.articles = response.articles
            })
            .store(in: &cancellables)
    }
}
