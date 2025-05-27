//
//  AppRootView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 16.05.2025.
//

import SwiftUI

enum AppScreen {
    case preview
    case previewSkip
    case home
}

struct AppRootView: View {
    // .preview
    @State private var currentScreen: AppScreen = .home
    
    var body: some View {

        switch currentScreen {
        case .preview:
            PreviewView {
                withAnimation {
                    currentScreen = .previewSkip
                }
            }
            .transition(.opacity)
            
        case .previewSkip:
            let dataSourse = RemotePreviewSkipDataSourseImpl()
            let repo = FetchPreviewSkipRepositoryImpl(dataSourse: dataSourse)
            let useCase = FetchPreviewSkipUseCaseImpl(repository: repo)
            
            PreviewSkipView(
                viewModel: PreviewSkipViewModel(fetchPreviewSkipUseCase: useCase),
                onSkip: {
                    withAnimation {
                        currentScreen = .home
                    }
                },
            )
            .transition(.opacity)
            
        case .home:
            
            let dataSourse = RemoteHousesDataSourseImpl()
            let repo = FetchHousesRepositoryImpl(dataSource: dataSourse)
            let useCase = FetchHousesUseCaseImpl(repository: repo)
            
            let dataSourseTravel = RemoteTravelDataSourseImpl()
            let repoTravel = FetchTravelRepositoryImpl(dataSourse: dataSourseTravel)
            let useCaseTravel = FetchTravelUseCaseImpl(repository: repoTravel)
            
            HomeView(viewModel: HomeViewModel(
                fetchHousesUseCase: useCase, fetchTravelUseCase: useCaseTravel)
            )
                .transition(.opacity)
        }

    }
}
