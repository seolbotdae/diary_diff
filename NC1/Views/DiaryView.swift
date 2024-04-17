//
//  DiaryView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/14/24.
//

import SwiftUI
import SwiftData

struct DiaryView: View {
    @Environment(\.modelContext) private var modelContext
    
    let tomorrow = Date() + 86400
    let today = Date()
    
    @State var dateFormatter: DateFormatter = DateFormatter()
    
    @State var tomorrowDateString: String = ""
    @State var todayDateString: String = ""
    
    @Query private var tomorrowJourney: [Journey]
    @Query private var todayJourney: [Journey]
    
    var body: some View {
        VStack {
            NavigationLink {
                DayDiaryView(journeyDate: tomorrow)
//                NextDayDiaryView(journeyDate: tomorrow)
            } label: {
                GroupBox {
                    VStack {
                        HStack(alignment: .center) {
                            Text("내일의 일기")
                                .font(.title)
                            
                            Spacer()
                            
                            Text(tomorrowDateString)
                                .font(.title2)
                                .foregroundStyle(.gray)
                        }
                        .padding(.bottom, 1)

                        HStack(alignment: .center) {
                            if tomorrowJourney.count >= 1 {
                                if tomorrowJourney[0].blocks.count > 0 {
                                    Text("작성된 일기가 있습니다. 내일 확인해 보세요!")
                                } else {
                                    Text("아직 일기를 작성하지 않았습니다.")
                                }
                            } else {
                                Text("아직 일기를 작성하지 않았습니다.")
                            }
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 12)
            
            NavigationLink {
                CurrentDayDiaryView(journeyDate: today)
            } label: {
                GroupBox {
                    VStack {
                        HStack(alignment: .center) {
                            Text("오늘의 일기")
                                .font(.title)
                            
                            Spacer()
                            
                            Text(todayDateString)
                                .font(.title2)
                                .foregroundStyle(.gray)
                        }
                        .padding(.bottom, 1)

                        HStack(alignment: .center) {
                            if todayJourney.count >= 1 {
                                if todayJourney[0].blocks.count > 0 {
                                    Text("작성된 일기가 있습니다!")
                                } else {
                                    Text("아직 일기를 작성하지 않았습니다.")
                                }
                            } else {
                                Text("아직 일기를 작성하지 않았습니다.")
                            }
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
        }
        .onAppear {
            dateFormatter.dateFormat = "M월 d일"
            
            tomorrowDateString = dateFormatter.string(from: tomorrow)
            todayDateString = dateFormatter.string(from: today)
            
            let tomorrowJourney = Journey(id: Date.getDateId(date: tomorrow), blocks: [])
            let todayJourney = Journey(id: Date.getDateId(date: today), blocks: [])
            
            modelContext.insert(tomorrowJourney)
            modelContext.insert(todayJourney)
        }
        .padding(.top, 20)
        .padding(.horizontal, 16)
    }
    
    init() {
        let nextDateId = Date.getDateId(date: Date() + 86400)
        let currentDateId = Date.getDateId(date: Date())
        
        let nextDatePredicate = #Predicate<Journey> { J in
            J.id == nextDateId
        }
        _tomorrowJourney = Query(filter: nextDatePredicate)
        
        let currentDatePredicate = #Predicate<Journey> { J in
            J.id == currentDateId
        }
        _todayJourney = Query(filter: currentDatePredicate)
    }
}

