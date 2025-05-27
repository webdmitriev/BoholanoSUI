//
//  SingleTravelView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import SwiftUI

struct SingleTravelView: View {
    
    var travel: Travel
    
    var body: some View {
        ScrollView {
            VStack {
                Text(travel.title)
            }
        }
    }
}
