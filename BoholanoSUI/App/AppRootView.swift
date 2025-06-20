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
    @State private var currentScreen: AppScreen = .preview
    @State private var lastScreenBeforeOffline: AppScreen? = nil
    @ObservedObject private var networkMonitor = NetworkMonitor.shared

    var body: some View {
        Group {
            if !networkMonitor.isConnected {
                OfflineView {
                    // при клике на кнопку пробуем вернуть экран, если сеть восстановилась
                    networkMonitor.monitor.pathUpdateHandler = { path in
                        if !path.isExpensive {
                            DispatchQueue.main.async {
                                networkMonitor.isConnected = true
                            }
                        }
                    }
                }
            } else {
                switch currentScreen {
                case .preview:
                    PreviewView {
                        withAnimation {
                            currentScreen = .previewSkip
                        }
                    }

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
                        }
                    )

                case .home:
                    let dataSourse = RemoteHousesDataSourseImpl()
                    let repo = FetchHousesRepositoryImpl(dataSource: dataSourse)
                    let useCase = FetchHousesUseCaseImpl(repository: repo)

                    let dataSourseTravel = RemoteTravelDataSourseImpl()
                    let repoTravel = FetchTravelRepositoryImpl(dataSourse: dataSourseTravel)
                    let useCaseTravel = FetchTravelUseCaseImpl(repository: repoTravel)

                    HomeView(viewModel: HomeViewModel(
                        fetchHousesUseCase: useCase,
                        fetchTravelUseCase: useCaseTravel)
                    )
                }
            }
        }
        .onChange(of: networkMonitor.isConnected) { oldValue, newValue in
            if newValue {
                withAnimation {
                    currentScreen = .preview
                }
            }
        }
        .animation(.easeInOut, value: networkMonitor.isConnected)
    }
}
