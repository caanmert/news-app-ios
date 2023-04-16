//
//  ArticleDetailViewModel.swift
//  news-app
//
//  Created by jaerka on 16.04.23.
//

import Foundation


import Foundation

class ArticleDetailViewModel: ObservableObject {
    
    var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var body: some View{
        
        VStack(spacing: 30) {
            RemoteImage(url: URL(string:article.urlToImage ?? ""))
            Text(article.title).font(.system(.headline, design: .serif))
            Spacer()
            Divider()
            GoToArticleButton(text: "Go To Article", action: { openURL(URL(string:article.url)!)})
        }.padding()
        
    }

}
