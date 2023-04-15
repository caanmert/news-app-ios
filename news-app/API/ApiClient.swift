
import Foundation

final class ApiClient: ObservableObject {
    @Published var articles: [Article] = []
    private var hasFetchedItems = false
    
    func getData() {
        guard !hasFetchedItems else { return }
        hasFetchedItems = true
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=gb&apiKey=4d43dd35bbbe4e7ea883b23460b16424") else { print("URL error"); return }
        print("some")
        URLSession.shared.dataTask(with: url)  { [weak self] (data, response, error) in
            guard let data = data else {return}
            let newsData = try! JSONDecoder().decode(NewsAPIResponse.self, from: data)
            DispatchQueue.main.async {
                self?.articles = newsData.articles
           
            }
        }.resume()
    }
}
