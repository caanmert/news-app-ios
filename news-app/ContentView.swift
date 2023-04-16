import Foundation
import SwiftUI

struct ContentView: View {
   @StateObject var viewModel = ArticleListViewModel()
    var body: some View {
        NavigationView{
            Group{
                if viewModel.isLoading{
                    ProgressView()
                } else if let error = viewModel.error{
                    Text(error.localizedDescription)
                } else {
                    List(viewModel.articles) { article in
                        NavigationLink(destination: ArticleDetailsView(article: article)){
                            //ext(article.title)
                            ArticleRowView(article: article)
                        }
                    }.navigationTitle("News")
                }
            }
        }.onAppear{
            viewModel.loadData()
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
