//
//  CustomRangeSlider.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 27.05.2025.
//

import SwiftUI

struct PriceFilter: Equatable {
    var minPrice: Double
    var maxPrice: Double

    var selectedMin: Double
    var selectedMax: Double
}

class PriceFilterViewModel: ObservableObject {
    @Published var filter: PriceFilter

    init(min: Double, max: Double) {
        self.filter = PriceFilter(
            minPrice: min,
            maxPrice: max,
            selectedMin: min,
            selectedMax: max
        )
    }
}

struct CustomRangeSlider: View {
    @Binding var lowerValue: Double
    @Binding var upperValue: Double

    let range: ClosedRange<Double>
    let step: Double

    var body: some View {
        GeometryReader { geometry in
            let sliderWidth = geometry.size.width
            let lowerThumbPosition = position(for: lowerValue, width: sliderWidth)
            let upperThumbPosition = position(for: upperValue, width: sliderWidth)

            ZStack(alignment: .leading) {
                // Background track
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 4)

                // Selected range track
                Capsule()
                    .fill(.appGreen)
                    .frame(width: upperThumbPosition - lowerThumbPosition, height: 4)
                    .offset(x: lowerThumbPosition)

                // Lower thumb
                Circle()
                    .fill(.appGreen)
                    .frame(width: 28, height: 28)
                    .position(x: lowerThumbPosition, y: 18)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let value = valueFrom(position: gesture.location.x, width: sliderWidth)
                                lowerValue = min(max(range.lowerBound, value), upperValue)
                            }
                    )

                // Upper thumb
                Circle()
                    .fill(.appGreen)
                    .frame(width: 28, height: 28)
                    .position(x: upperThumbPosition, y: 18)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let value = valueFrom(position: gesture.location.x, width: sliderWidth)
                                upperValue = max(min(range.upperBound, value), lowerValue)
                            }
                    )
            }
            .frame(height: 40)
        }
        .frame(height: 40)
        .padding(.horizontal, 32)
    }

    private func position(for value: Double, width: CGFloat) -> CGFloat {
        let percentage = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return CGFloat(percentage) * width
    }

    private func valueFrom(position: CGFloat, width: CGFloat) -> Double {
        let percent = min(max(0, position / width), 1)
        let totalSteps = (range.upperBound - range.lowerBound) / step
        let stepped = round(percent * totalSteps)
        return range.lowerBound + stepped * step
    }
}
