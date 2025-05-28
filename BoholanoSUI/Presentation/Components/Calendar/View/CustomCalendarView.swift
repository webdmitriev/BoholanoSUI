//
//  CustomCalendarView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 28.05.2025.
//


import SwiftUI

struct CustomCalendarView: View {
    @ObservedObject private var viewModel: CalendarViewModel
    
    var onDateRangeSelected: ((Date?, Date?) -> Void)? = nil

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    init(viewModel: CalendarViewModel, onDateRangeSelected: ((Date?, Date?) -> Void)? = nil) {
        self.viewModel = viewModel
        self.onDateRangeSelected = onDateRangeSelected
    }
    
    var body: some View {
        VStack(spacing: 12) {
            // 🔹 Навигация
            HStack {
                Button(action: { viewModel.goToPreviousMonth() }) {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(currentMonthText)
                    .font(.headline)

                Spacer()

                Button(action: { viewModel.goToNextMonth() }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            // 🔹 Заголовки дней недели
            let daysOfWeek = Calendar.current.shortWeekdaySymbols
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day).font(.subheadline).foregroundColor(.gray)
                }
            }

            // 🔹 Сетка дат
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.days, id: \.self) { date in
                    DayCell(date: date, viewModel: viewModel)
                }
            }
            .padding(.horizontal)

            // 🔹 Выбранный диапазон
            if !viewModel.selectedRangeText.isEmpty {
                Text(viewModel.selectedRangeText)
                    .padding(.top)
                    .font(.headline)
            }

            // 🔹 Кнопка продолжения
            if viewModel.selectedStartDate != nil && viewModel.selectedEndDate != nil {
                Button("Продолжить") {
                    onDateRangeSelected?(viewModel.selectedStartDate, viewModel.selectedEndDate)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }

    private var currentMonthText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: viewModel.currentMonth).capitalized
    }
}
