//
//  PreviewSkipViewModel.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 15.05.2025.
//

import SwiftUI
import Combine

@MainActor
class PreviewSkipViewModel: ObservableObject {
    private let imageCache = NSCache<NSString, UIImage>()

    @Published var previewSkips: [PreviewSkipEntities] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let fetchPreviewSkipUseCase: FetchPreviewSkipUseCase
    init(fetchPreviewSkipUseCase: FetchPreviewSkipUseCase) {
        self.fetchPreviewSkipUseCase = fetchPreviewSkipUseCase
    }
    
    func getPreviewSkips() {
        self.fetchPreviewSkipUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print(err.localizedDescription)
                    default : break
                }
            } receiveValue: { [weak self] previews in
                self?.previewSkips = previews
            }
            .store(in: &cancellables)
            
    }
    
    func cachedImage(at index: Int) -> UIImage? {
        guard previewSkips.indices.contains(index) else { return nil }
        let url = previewSkips[index].image
        return imageCache.object(forKey: url as NSString)
    }
    
    func cacheImage(_ image: UIImage, for url: String) {
        imageCache.setObject(image, forKey: url as NSString)
    }
    
}
