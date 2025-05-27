//
//  FilterSheetView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import SwiftUI

struct FilterSheetView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            
            Text("Filter Hotel:")
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.appBlack)
            
            // элементы фильтрации (пока просто заглушка)
            Spacer()
            
            Button("Close") {
                dismiss()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .padding()
    }
}
