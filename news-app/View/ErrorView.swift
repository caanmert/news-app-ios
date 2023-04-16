//
//  ErrorView.swift
//  news-app
//
//  Created by jaerka on 16.04.23.
//

import Foundation
import SwiftUI

struct ErrorView:View{
    var viewModel : ArticleListViewModel
    
    var body: some View {
        VStack{
            Text(viewModel.error?.localizedDescription ?? "Something wrong is happened!")
            Spacer()
            CustomButton(text: "Try Again!", action: {viewModel.loadData()})
        }
    }
}



