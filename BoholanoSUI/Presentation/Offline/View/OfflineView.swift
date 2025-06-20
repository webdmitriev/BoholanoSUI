//
//  OfflineView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 17.06.2025.
//

import SwiftUI

struct OfflineView: View {
    var onRetry: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)

            Text("Нет подключения к интернету")
                .font(.title3)
                .multilineTextAlignment(.center)

            Button("Повторить попытку") {
                onRetry()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
