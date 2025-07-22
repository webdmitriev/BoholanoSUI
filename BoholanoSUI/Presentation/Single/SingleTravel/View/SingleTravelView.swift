//
//  SingleTravelView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import SwiftUI

enum ContentPart {
    case text(String)
    case image(URL)
}

struct SingleTravelView: View {
    @Environment(\.dismiss) var dismiss
    
    var travel: Travel

    var body: some View {
        let parts = parseDescr(travel.descr)
        
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(travel.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                        .bold()
                        .padding(.bottom, 2)
                    
                    ForEach(parts.indices, id: \.self) { index in
                        switch parts[index] {
                        case .text(let text):
                            Text(text)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                        case .image(let url):
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(8)
                                case .failure:
                                    Image("boholano-default")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity, maxHeight: 280)
                                        .cornerRadius(8)
                                        .clipped()
                                    
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .padding(.top, 50)
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrowshape.backward")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.black)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func parseDescr(_ descr: String) -> [ContentPart] {
        // Заменяем <br> и <br/> на перенос строки
        let cleanedDescr = descr
            .replacingOccurrences(of: "<br>", with: "\n")
            .replacingOccurrences(of: "<br/>", with: "\n")
            .replacingOccurrences(of: "<br />", with: "\n")

        let pattern = #"https?:\/\/\S+\.(png|jpg|jpeg|gif)"#
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let nsrange = NSRange(cleanedDescr.startIndex..<cleanedDescr.endIndex, in: cleanedDescr)

        var result: [ContentPart] = []
        var lastIndex = cleanedDescr.startIndex

        regex?.enumerateMatches(in: cleanedDescr, options: [], range: nsrange) { match, _, _ in
            guard let match = match,
                  let range = Range(match.range, in: cleanedDescr),
                  let url = URL(string: String(cleanedDescr[range]))
            else { return }

            let textRange = lastIndex..<range.lowerBound
            let text = cleanedDescr[textRange].trimmingCharacters(in: .whitespacesAndNewlines)
            if !text.isEmpty {
                result.append(.text(text))
            }

            result.append(.image(url))
            lastIndex = range.upperBound
        }

        let remainingText = cleanedDescr[lastIndex...].trimmingCharacters(in: .whitespacesAndNewlines)
        if !remainingText.isEmpty {
            result.append(.text(remainingText))
        }

        return result
    }
}


