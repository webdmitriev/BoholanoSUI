//
//  CalendarViewModel.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 28.05.2025.
//


import Foundation

class CalendarViewModel: ObservableObject {
    @Published var selectedStartDate: Date? = nil
    @Published var selectedEndDate: Date? = nil
    
    var unavailableDateRanges: [DateInterval] = []
    @Published var currentMonth: Date = Date()
    
    private let calendar = Calendar.current
    
    var days: [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth) else { return [] }

        var days: [Date?] = []
        let firstWeekday = calendar.component(.weekday, from: monthInterval.start)

        let emptySlots = (firstWeekday - calendar.firstWeekday + 7) % 7
        days.append(contentsOf: Array(repeating: nil, count: emptySlots))

        var date = monthInterval.start
        while date < monthInterval.end {
            days.append(date)
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }

        return days
    }
    
    var selectedRangeText: String {
        guard let start = selectedStartDate, let end = selectedEndDate else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        
        return "Дата заселения \(formatter.string(from: start)) - \(formatter.string(from: end))"
    }
    
    init(unavailableDateRanges: [DateInterval] = []) {
        self.unavailableDateRanges = unavailableDateRanges
    }
    
    func isUnavailable(_ date: Date) -> Bool {
        unavailableDateRanges.contains { interval in
            interval.contains(date)
        }
    }

    func selectDate(_ date: Date) {
        guard !isUnavailable(date) else { return }

        if selectedStartDate == nil || (selectedStartDate != nil && selectedEndDate != nil) {
            selectedStartDate = date
            selectedEndDate = nil
        } else if let start = selectedStartDate {
            if date >= start {
                let startOfDay = Calendar.current.startOfDay(for: start)
                let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: date)!

                let range = DateInterval(start: startOfDay, end: endOfDay)

                // Проверка: есть ли пересечение с занятыми датами
                let containsUnavailable = unavailableDateRanges.contains { $0.intersects(range) }

                if !containsUnavailable {
                    selectedEndDate = date
                } else {
                    // ❌ В диапазоне есть занятые даты — не устанавливаем конечную дату
                    print("Выбранный диапазон включает занятые даты. Выбор невозможен.")
                }
            } else {
                // Если клик назад — начинаем новую цепочку
                selectedStartDate = date
                selectedEndDate = nil
            }
        }
    }
    
    func isBetweenSelectedDates(_ date: Date) -> Bool {
        guard let start = selectedStartDate,
              let end = selectedEndDate else { return false }

        return date > start && date < end
    }
    
    func goToPreviousMonth() {
        guard let previous = calendar.date(byAdding: .month, value: -1, to: currentMonth) else { return }
        currentMonth = previous
    }

    func goToNextMonth() {
        guard let next = calendar.date(byAdding: .month, value: 1, to: currentMonth) else { return }
        currentMonth = next
    }
}
