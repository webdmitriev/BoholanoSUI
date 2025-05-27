//
//  SingleSheetReviewView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 21.05.2025.
//

import SwiftUI

struct SingleSheetReviewView: View {
    
    var review: Review
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    VStack(spacing: 8) {
                        Text(review.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.appBlack)
                        
                        Text(review.date)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.appGray)
                    }
                    
                    HStack(spacing: 12) {
                        Image(systemName: "star")
                            .frame(width: 14, height: 14)
                            .foregroundStyle(.appWhite)
                        
                        Text(review.rating)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.appWhite.opacity(0.8))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.appGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                
                Text(review.descr)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 17, weight: .regular))
                    .lineSpacing(2)
                    .foregroundStyle(.appBlack)
                
                Spacer()
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 22)
    }
}
