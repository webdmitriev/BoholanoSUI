//
//  SearchListView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import SwiftUI

struct SearchListView: View {
    
    var searchText: String = ""
    
    var body: some View {
        VStack {
            Text(searchText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.appBlack)
        }
    }
}
