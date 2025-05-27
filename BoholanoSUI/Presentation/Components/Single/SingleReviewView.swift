//
//  SingleReviewView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 21.05.2025.
//

import SwiftUI

struct SingleReviewView: View {
    
    var title: String = ""
    var reviews: [Review] = []
    
    @State private var presentedReview: Review?
    
    @State var isExpanded: Bool = false

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.appBlack)
            
            LazyVStack(spacing: 24) {
                ForEach(reviews, id: \.self) { review in
                    SingleReviewItemView(rev: review)
                        .onTapGesture {
                            presentedReview = review
                        }
                }
            }
        }
        .padding(.horizontal, 16)
        .sheet(item: $presentedReview) { review in
            SingleSheetReviewView(review: review)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

struct SingleReviewItemView: View {

    let rev: Review
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(rev.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.appBlack)
                    
                    Spacer(minLength: 8)
                    
                    Text(rev.date)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.appGray)
                }
                
                HStack(spacing: 12) {
                    Image(systemName: "star")
                        .frame(width: 14, height: 14)
                        .foregroundStyle(.appWhite)
                    
                    Text(rev.rating)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.appWhite.opacity(0.8))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.appGreen)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            
            Spacer(minLength: 16)
            
            Text(rev.descr)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .regular))
                .lineSpacing(2)
                .foregroundStyle(.appBlack)
                .lineLimit(4)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 22)
        .background(.appWhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 5, y: -2)
    }
}
