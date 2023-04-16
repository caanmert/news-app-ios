
import Foundation
import Combine
import SwiftUI

class ArticleListViewModel:ObservableObject{
    
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var error: Error? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    private let newsApiProtocol: NewsAPIProtocol
    
    init(newsApiProtocol: NewsAPIProtocol = NewsAPI()){
        self.newsApiProtocol = newsApiProtocol
     //   loadData()
    }
    
    
    func loadData(country:String = "gb") {
        isLoading = true
        newsApiProtocol.fetchArticles(country: country)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
                self.isLoading = false
            }, receiveValue: {NewsAPIResponse in
                self.articles = NewsAPIResponse.articles
            })
            .store(in: &cancellables)
    }
    

}
