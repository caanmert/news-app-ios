import SwiftUI

struct ContentView: View {
    @StateObject private var api = ApiClient()
    var body: some View {
        NavigationView{
            List(api.articles){ article in
                NavigationLink(destination:ArticleDetailsView(article: article)){
                    ArticleView(article: article)
                }
            }
            .navigationTitle("UK News")
            .onAppear{
                api.getData()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
