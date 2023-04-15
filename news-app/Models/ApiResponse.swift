
import Foundation

struct NewsAPIResponse: Codable{
    let status:String
    let totalResults:Int
    let articles:[Article]
    
}



