

import Foundation


struct Article:Codable,Identifiable{
    let id=UUID()
    let source:Source
    let title:String
    let url:String
    let publishedAt:String?
    
    let author:String?
    let description:String?
    let urlToImage:String?
}

struct Source:Codable{
    let id:String?
    let name:String
}
