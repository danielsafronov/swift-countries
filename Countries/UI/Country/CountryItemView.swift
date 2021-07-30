//
//  CountryItemView.swift
//  Countries
//
//  Created by Daniel Safronov on 29.07.2021.
//

import SwiftUI

struct CountryItemView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .bold()
            
            Spacer()
            
            Text(value)
                .font(.body)
                .foregroundColor(Color(.systemGray2))
        }
    }
}

struct CountryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CountryItemView(title: "Title", value: "Value")
            .previewLayout(.fixed(width: 400, height: 70))
    }
}
