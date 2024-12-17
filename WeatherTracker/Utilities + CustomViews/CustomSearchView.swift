//
//  CustomSearchView.swift
//  WeatherTracker
//
//  Created by Chirag Anghan on 2024-12-17.
//

import SwiftUI

struct CustomSearchView: View {
    @State var searchText: String
    let searchCity: (String) -> Void
    
    var body: some View {
        ZStack(alignment: .trailing) {
                    TextField("Search Location", text: $searchText)
                        .autocorrectionDisabled()
                        .padding(12)
                        .padding(.leading, 16)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                        .padding(.horizontal, 10)
                        .onSubmit {
                            searchCity(searchText)
                            searchText = ""
                        }
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.trailing, 32)
                        .onTapGesture {
                            searchCity(searchText)
                            searchText = ""
                        }
                }
                .frame(height: 40)
    }
}


#Preview {
    CustomSearchView(searchText: "Mumbai") { _ in }
}
