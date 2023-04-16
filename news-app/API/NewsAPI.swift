
import Foundation
import Combine


final class NewsAPI: NewsAPIProtocol {
    
    //TODO:ADD URL AND APIKEY TO ENVIRONMENT VARIABLES
    private let apiKey = "4d43dd35bbbe4e7ea883b23460b16424"
    private let baseURL = URL(string: "https://newsapi.org/v2")!
    
   
     func fetchArticles(country:String) -> AnyPublisher<NewsAPIResponse, Error> {
           let url = baseURL.appendingPathComponent("top-headlines")
           var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
           components.queryItems = [
               URLQueryItem(name: "country", value: country),
               URLQueryItem(name: "apiKey", value: apiKey)
           ]
           let request = URLRequest(url: components.url!)

           return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                       guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                           throw APIError.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)
                       }
                       return data
                   }
               .mapError { error -> Error in
                   switch error {
                   case URLError.networkConnectionLost:
                       return APIError.connectionLost
                   case URLError.notConnectedToInternet:
                       return APIError.noInternetConnection
                   default:
                       return error
                   }
               }
               .decode(type: NewsAPIResponse.self, decoder: JSONDecoder())
               .mapError { error -> Error in
                   APIError.decodingError(error)
               }
               .eraseToAnyPublisher()
       }
    
}

