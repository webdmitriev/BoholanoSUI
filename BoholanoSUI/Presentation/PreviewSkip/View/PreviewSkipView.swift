//
//  PreviewSkipView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 15.05.2025.
//

import SwiftUI

struct PreviewSkipView: View {

    @StateObject var viewModel: PreviewSkipViewModel
    @State private var currentIndex = 0
    
    // Замыкание для кнопки Next
    var onSkip: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {

            if !viewModel.previewSkips.isEmpty {
                
                // Предыдущее изображение
                if let prevImage = viewModel.cachedImage(at: currentIndex - 1) {
                    Image(uiImage: prevImage)
                        .resizable()
                        .scaledToFill()
                        .opacity(0.3)
                        .ignoresSafeArea()
                }
                
                // Текущее изображение
                NetworkImage(url: viewModel.previewSkips[currentIndex].image)
                    .ignoresSafeArea()
                

                
                VStack {
                    Text(viewModel.previewSkips[currentIndex].title.decodingHTMLEntities())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 16)
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(.appBlack)
                    
                    Text(viewModel.previewSkips[currentIndex].descr)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 24)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(.appGray)
                    

                    HStack(spacing: 12) {
                        ForEach(0..<viewModel.previewSkips.count, id: \.self) { index in
                            Capsule()
                                .fill(index == currentIndex ? Color.appGreen : Color.appBlack.opacity(0.3))
                                .frame(
                                    width: index == currentIndex ? 30 : 8,
                                    height: 8
                                )
                                .animation(.easeInOut, value: currentIndex)
                        }
                    }
                    .padding(.bottom, 20)
                    

                    Button {
                        guard !viewModel.previewSkips.isEmpty else { return }
                        withAnimation {
                            currentIndex = (currentIndex + 1) % viewModel.previewSkips.count
                        }
                    } label: {
                        Text("Next")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 18, weight: .bold))
                            .padding(10)
                            .foregroundStyle(.appWhite)
                    }
                    .background(Color.appGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom, 4)
                    
                    Button(action: onSkip) {
                        Text("Skip")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 18, weight: .bold))
                            .padding(10)
                            .foregroundStyle(.appGreen)
                    }
                    .background(Color.appGreenLight.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 48)

            } else {
                ProgressView()
            }
        }
        .animation(.easeInOut(duration: 0.4), value: currentIndex)
        .onAppear {
            viewModel.getPreviewSkips()
        }
    }
}



extension String {
    func decodingHTMLEntities() -> String {
        var result = self
        // Сначала заменяем HTML-сущности
        let entities = [
            "&#8217;": "'",
            "&quot;": "\"",
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">",
            "\\n": "\n"  // Добавляем обработку переносов строк
        ]
        
        for (entity, replacement) in entities {
            result = result.replacingOccurrences(of: entity, with: replacement)
        }
        
        // Дополнительная обработка HTML-тегов (если нужно)
        result = result.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        
        return result
    }
}
