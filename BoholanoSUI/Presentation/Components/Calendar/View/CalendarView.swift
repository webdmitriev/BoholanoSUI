//
//  CalendarView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 28.05.2025.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedStartDate: Date? = nil
    @State private var selectedEndDate: Date? = nil

    var body: some View {
        VStack {
            Text("Calendar")
            
            CustomCalendarView(
                viewModel: CalendarViewModel(unavailableDateRanges: [
                    DateInterval(start: dateFrom(day: 5, month: 6, year: 2025),
                                 end: dateFrom(day: 11, month: 6, year: 2025)),
                    DateInterval(start: dateFrom(day: 20, month: 6, year: 2025),
                                 end: dateFrom(day: 23, month: 6, year: 2025))
                ]),
                onDateRangeSelected: { start, end in
                    selectedStartDate = start
                    selectedEndDate = end
                    print("Выбран период: \(start?.description ?? "nil") - \(end?.description ?? "nil")")
                }
            )
            
            if let start = selectedStartDate, let end = selectedEndDate {
                Text("Выбран с \(start, formatter: dateFormatter) по \(end, formatter: dateFormatter)")
                    .padding()
            }
        }
    }
    
    func dateFrom(day: Int, month: Int, year: Int) -> Date {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        return Calendar.current.date(from: components)!
    }
    
    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "dd MMMM yyyy"
        return f
    }
}

#Preview {
    CalendarView()
}
