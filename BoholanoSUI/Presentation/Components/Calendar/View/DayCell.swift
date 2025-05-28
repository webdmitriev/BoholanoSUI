//
//  DayCell.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 28.05.2025.
//

import SwiftUI

struct DayCell: View {
    let date: Date?
    @ObservedObject var viewModel: CalendarViewModel

    private let calendar = Calendar.current

    var body: some View {
        Group {
            if let date {
                let isInRange = isDateInRange(date)
                let isStart = isStartDate(date)
                let isEnd = isEndDate(date)
                let isToday = calendar.isDateInToday(date)
                let isPast = self.isPast(date)
                let isUnavailable = self.isUnavailable(date)

                Text("\(calendar.component(.day, from: date))")
                    .frame(width: 32, height: 32)
                    .background(
                        ZStack {
                            if isStart || isEnd {
                                Color.green
                            } else if isInRange {
                                Color.green.opacity(0.3)
                            } else if isUnavailable {
                                // Более яркое выделение занятых дат
                                Color.red.opacity(0.7)
                            } else {
                                Color.clear
                            }
                        }
                    )
                    .foregroundColor(textColor(isPast: isPast, isUnavailable: isUnavailable, isInRange: isInRange, isStart: isStart, isEnd: isEnd))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(isToday ? Color.green : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        if !isPast && !isUnavailable {
                            viewModel.selectDate(date)
                        }
                    }
                    .opacity(isPast || isUnavailable ? 0.5 : 1.0)

            } else {
                Color.clear.frame(width: 32, height: 32)
            }
        }
    }

    private func isStartDate(_ date: Date) -> Bool {
        guard let start = viewModel.selectedStartDate else { return false }
        return calendar.isDate(date, inSameDayAs: start)
    }

    private func isEndDate(_ date: Date) -> Bool {
        guard let end = viewModel.selectedEndDate else { return false }
        return calendar.isDate(date, inSameDayAs: end)
    }

    private func isDateInRange(_ date: Date) -> Bool {
        guard let start = viewModel.selectedStartDate,
              let end = viewModel.selectedEndDate else { return false }
        return date > start && date < end
    }

    private func background(for date: Date, isInRange: Bool, isStart: Bool, isEnd: Bool) -> some View {
        if isStart || isEnd {
            return Color.green
        } else if isInRange {
            return Color.green.opacity(0.3)
        } else {
            return Color.clear
        }
    }
    
    private func isPast(_ date: Date) -> Bool {
        return date < calendar.startOfDay(for: Date())
    }
    
    private func textColor(isPast: Bool, isUnavailable: Bool, isInRange: Bool, isStart: Bool, isEnd: Bool) -> Color {
         if isPast || isUnavailable {
             return .gray
         } else if isStart || isEnd || isInRange {
             return .white
         } else {
             return .black
         }
    }
    
    private func isUnavailable(_ date: Date) -> Bool {
        return viewModel.isUnavailable(date)
    }
}
