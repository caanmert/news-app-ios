

import Foundation
import SwiftUI
import SafariServices

struct ArticleView:View{
    let article:Article
    
    var body: some View{
        VStack(alignment: .leading, spacing: 12) {
            Text(article.title).font(.system(.headline, design: .serif))
            Text(article.author ?? "Author")
            HStack{
                Text(article.source.name)
                Spacer()
                Text(formatDateString(dateString: article.publishedAt)).font(.caption)
            }
            
        }
        
    }
}

