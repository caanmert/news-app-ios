//
//  NewsAPIProtocol.swift
//  news-app
//
//  Created by jaerka on 16.04.23.
//

import Foundation
import Combine


protocol NewsAPIProtocol {
    func fetchArticles(country: String) -> AnyPublisher<NewsAPIResponse, Error>
}

