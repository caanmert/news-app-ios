
import Foundation

func formatDateString(dateString: String?) -> String {
    guard let dateString = dateString else {
        return ""
    }
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
    
    guard let date = dateFormatterGet.date(from: dateString) else {
        return ""
    }
    
    return dateFormatterPrint.string(from: date)
}
