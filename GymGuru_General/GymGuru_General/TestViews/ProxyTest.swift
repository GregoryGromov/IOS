//
//  ProxyTest.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 15.01.2024.
//

import SwiftUI
import Charts


struct FoodIntake: Hashable {
  let date: Date
  let calories: Int
}

func date(year: Int, month: Int, day: Int) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}

let intake = stride(from: 1, to: 31, by: 1).map { day in
  FoodIntake(date: date(year: 2022, month: 5, day: day), calories: Int.random(in: 1800...2200))
}

struct ProxyTest: View {
  @State var selectedElement: FoodIntake?
    
    var body: some View {
        VStack {
            Button("Test It") {
                let date = Date() // Получаем текущую дату

                let calendar = Calendar.current
                let dayOfWeek = calendar.component(.weekday, from: date)
                
                print("Функция выдала вот это: \(dayOfWeek). Если тут 3, то все заебись")
            }
            
            Chart {
              ForEach(intake, id: \.self) { data in
                BarMark(x: .value("Date", data.date),
                        y: .value("Calories", data.calories))
              }
            }
            .chartOverlay { proxy in
                GeometryReader { geo in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(
                            SpatialTapGesture()
                                .onEnded { value in
                                    let element = findElement(location: value.location, proxy: proxy, geometry: geo)
                                    if selectedElement?.date == element?.date {
                                        // If tapping the same element, clear the selection.
                                        selectedElement = nil
                                    } else {
                                        selectedElement = element
                                    }
                                }
                                .exclusively(
                                    before: DragGesture()
                                        .onChanged { value in
                                            selectedElement = findElement(location: value.location, proxy: proxy, geometry: geo)
                                        }
                                )
                        )
                }
            }
            .chartBackground { proxy in
                ZStack(alignment: .topLeading) {
                    GeometryReader { geo in
                        if let selectedElement = selectedElement {
                            let dateInterval = Calendar.current.dateInterval(of: .day, for: selectedElement.date)!
                            let startPositionX = proxy.position(forX: dateInterval.start) ?? 0
                            let midStartPositionX = startPositionX + geo[proxy.plotAreaFrame].origin.x
                            let lineHeight = geo[proxy.plotAreaFrame].maxY
                            let boxWidth: CGFloat = 150
                            let boxOffset = max(0, min(geo.size.width - boxWidth, midStartPositionX - boxWidth / 2))

                          Rectangle()
                              .fill(.quaternary)
                              .frame(width: 2, height: lineHeight)
                              .position(x: midStartPositionX, y: lineHeight / 2)

                            VStack(alignment: .leading) {
                              Text("\(selectedElement.date, format: .dateTime.year().month().day())")
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                                Text("\(selectedElement.calories, format: .number) calories")
                                    .font(.title2.bold())
                                    .foregroundColor(.primary)
                            }
                            .frame(width: boxWidth, alignment: .leading)
                            .background {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.background)
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.quaternary.opacity(0.7))
                                }
                                .padding([.leading, .trailing], -8)
                                .padding([.top, .bottom], -4)
                            }
                            .offset(x: boxOffset)
                        }
                    }
                }
            }
            .frame(height: 250)
            .padding()
        }
  }

  func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> FoodIntake? {
      let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
      if let date = proxy.value(atX: relativeXPosition) as Date? {
          // Find the closest date element.
          var minDistance: TimeInterval = .infinity
          var index: Int? = nil
          for dataIndex in intake.indices {
              let nthDataDistance = intake[dataIndex].date.distance(to: date)
              if abs(nthDataDistance) < minDistance {
                  minDistance = abs(nthDataDistance)
                  index = dataIndex
              }
          }
          if let index = index {
              return intake[index]
          }
      }
      return nil
  }
}

//struct ProxyTest: View {
//    @State private var selectedRange: ClosedRange<Int>?
//    @State private var numbers = (0..<10)
//        .map { _ in Double.random(in: 0...10) }
//    
//    var body: some View {
//        Chart(Array(zip(numbers.indices, numbers)), id: \.1) { index, number in
//            LineMark(
//                x: .value("Index", index),
//                y: .value("Number", number)
//            )
//            
//            if let selectedRange {
//                RectangleMark(
//                    xStart: .value("Index", selectedRange.lowerBound),
//                    xEnd: .value("Index", selectedRange.upperBound),
//                    yStart: .value("Number", 0),
//                    yEnd: .value("Number", 10)
//                )
//                .foregroundStyle(.blue.opacity(0.03 ))
//            }
//        }
//        .chartXSelection(range: $selectedRange)
//        .chartGesture { chart in
//            DragGesture(minimumDistance: 16)
//                .onChanged {
//                    chart.selectXRange(
//                        from: $0.startLocation.x,
//                        to: $0.location.x
//                    )
//                }
//                .onEnded { _ in selectedRange = nil }
//        }
//    }
//}

//struct ProxyTest: View {
//    @State private var selectedIndex: Int?
//    @State private var numbers = (0..<10)
//        .map { _ in Double.random(in: 0...10) }
//    
//    var body: some View {
//        Chart(Array(zip(numbers.indices, numbers)), id: \.1) { index, number in
//            LineMark(
//                x: .value("Index", index),
//                y: .value("Number", number)
//            )
//            
//            if let selectedIndex {
//                RuleMark(x: .value("Index", selectedIndex))
//                    .annotation(position: .bottom) {
//                        Text(verbatim: selectedIndex.formatted())
//                            .padding()
//                            .background(.regularMaterial)
//                    }
//            }
//        }
//        .chartOverlay { chart in
//            GeometryReader { geometry in
//                Rectangle().fill(.primary.opacity(0.01)).containerShape(.rect)
//                    .gesture(
//                        DragGesture()
//                            .onEnded { _ in
//                                selectedIndex = nil
//                            }
//                            .onChanged { value in
//                                guard let plotFrame = chart.plotFrame else {
//                                    return
//                                }
//                                
//                                let startX = geometry[plotFrame].origin.x
//                                let currentX = value.location.x - startX
//                                
//                                if let index: Int = chart.value(atX: currentX) {
//                                    selectedIndex = index
//                                }
//                            }
//                    )
//            }
//        }
//    }
//}



//при проводе по графику пальцем около контрольных точек появляются прямоугольники

//struct ProxyTest: View {
//    @State private var selectedIndex: Int? = nil
//    @State private var numbers = (0...10).map { _ in
//        Int.random(in: 0...10)
//    }
//    
//    var body: some View {
//        Chart {
//                    ForEach(Array(zip(numbers, numbers.indices)), id: \.0) { number, index in
//                        if let selectedIndex, selectedIndex == index {
//                            RectangleMark(
//                                x: .value("Index", index),
//                                yStart: .value("Value", 0),
//                                yEnd: .value("Value", number),
//                                width: 16
//                            )
//                            .opacity(0.4)
//                        }
//
//                        LineMark(
//                            x: .value("Index", index),
//                            y: .value("Value", number)
//                        )
//                    }
//                }
//        .chartOverlay { chart in
//            GeometryReader { geometry in
//                Rectangle()
//                    .fill(Color.clear)
//                    .contentShape(Rectangle())
//                    .gesture(
//                        DragGesture()
//                            .onChanged { value in
//                                let currentX = value.location.x - geometry[chart.plotAreaFrame].origin.x
//                                guard currentX >= 0, currentX < chart.plotAreaSize.width else {
//                                    return
//                                }
//                                
//                                guard let index = chart.value(atX: currentX, as: Int.self) else {
//                                    return
//                                }
//                                selectedIndex = index
//                            }
//                            .onEnded { _ in
//                                selectedIndex = nil
//                            }
//                    )
//            }
//        }
//    }
//}

// ЧТОБЫ ГРАФИК МЕНЯЛ ЦВЕТ ПО КАСАНИЮ

//struct ProxyTest: View {
//    @State private var isDragging = false
//    @State private var numbers = (0...10).map { _ in
//        Int.random(in: 0...10)
//    }
//    
//    var body: some View {
//        Chart {
//            ForEach(Array(zip(numbers, numbers.indices)), id: \.0) { number, index in
//                LineMark(
//                    x: .value("Index", index),
//                    y: .value("Value", number)
//                )
//                .foregroundStyle(isDragging ? .red : .blue)
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { _ in isDragging = true }
//                .onEnded { _ in isDragging = false }
//        )
//    }
//}





//struct ProxyTest: View {
//    
//    struct dataTest: Identifiable {
//        let id = UUID()
//        let date: Int
//        let price: Int
//    }
//    
//    let data = [
//        dataTest(date: 1, price: 100),
//        dataTest(date: 2, price: 50),
//        dataTest(date: 3, price: 200),
//        dataTest(date: 4, price: 150),
//    ]
//    
//    var body: some View {
//        Chart(data) {
//            LineMark(
//                x: .value("date", $0.date),
//                y: .value("price", $0.price)
//            )
//        }
//        .chartOverlay { proxy in
//            GeometryReader { geometry in
//                Rectangle().fill(.clear).contentShape(Rectangle())
//                    .gesture(
//                        DragGesture()
//                            .onChanged { value in
//                                // Convert the gesture location to the coordinate space of the plot area.
//                                let origin = geometry[proxy.plotAreaFrame].origin
//                                let location = CGPoint(
//                                    x: value.location.x - origin.x,
//                                    y: value.location.y - origin.y
//                                )
//                                // Get the x (date) and y (price) value from the location.
//                                let (date, price) = proxy.value(at: location, as: (Int, Int).self) ?? (0, 0)
//                                print("Location: \(date), \(price)")
//                            }
//                    )
//            }
//        }
//    }
//}

