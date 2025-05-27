//
//  ContentView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 15.05.2025.
//

import SwiftUI

struct PreviewView: View {
    
    var onCompletion: () -> Void
    private let wavingHandEmojis = ["👋🏻", "🖐️", "🤚", "🤟", "✌🏻"]
    
    var body: some View {

        ZStack(alignment: .bottomLeading) {
            
            Image("preview-01")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            BgGradient(height: 240)
            
            VStack {
                Text("Welcome to \(wavingHandEmojis[Int.random(in: 0..<wavingHandEmojis.count)])")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 0)
                    .font(.system(size: 32, weight: .regular, design: .default))
                    .foregroundStyle(.appWhite)
                
                Text("Bohol")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 2)
                    .font(.system(size: 82, weight: .bold, design: .default))
                    .foregroundStyle(.appGreen)
                
                Text("The best hotel booking in this century to accompany your vacation")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .foregroundStyle(.appWhite)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                onCompletion()
            }
        }
    }
}
