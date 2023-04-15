import Foundation
import SwiftUI

struct ArticleDetailsView:View{
    let article:Article
    @Environment(\.openURL) var openURL
    
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


