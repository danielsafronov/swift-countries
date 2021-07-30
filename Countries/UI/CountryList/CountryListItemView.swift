//
//  CountryListItemView.swift
//  Countries
//
//  Created by Daniel Safronov on 26.07.2021.
//

import SwiftUI

struct CountryListItemView: View {
    let title: String
    let code: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .bold()
            
            Spacer()
            
            Text(code)
                .font(.body)
                .foregroundColor(Color(.systemGray2))
        }
    }
}

struct CountryListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListItemView(title: "Country Title", code: "Country Code")
            .previewLayout(.fixed(width: 400, height: 70))
    }
}
