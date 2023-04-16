
import Foundation
import SwiftUI


struct CustomButton: View{
    var text:String
    var action: () -> Void
    
    var body: some View{
        Button(action:action){
        Text(text)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 75)
            .cornerRadius(30)
            .shadow(radius: 40)
            
        }
        .background(Color.blue)
        .padding(.top)
        .padding(.horizontal)
    
        
    }
    
}
