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
    @State private var nextDayJourneyId = Date.getDateId(date: Date() + 86400)
    @State private var currentDayJourneyId = Date.getDateId(date: Date())
    
    let nextMonthDay: String
    let currentMonthDay: String
    
    @Query private var nextDayJourney: [Journey]
    @Query private var currentDayJourney: [Journey]
    
    var body: some View {
        VStack {
            NavigationLink {
                NextDayDiaryView(journeyDate: (Date() + 86400))
            } label: {
                GroupBox {
                    VStack {
                        HStack(alignment: .center) {
                            Text("내일의 일기")
                                .font(.title)
                            
                            Spacer()
                            
                            Text(nextMonthDay)
                                .font(.title2)
                                .foregroundStyle(.gray)
                        }
                        .padding(.bottom, 1)

                        HStack(alignment: .center) {
                            if nextDayJourney.count >= 1 {
                                if nextDayJourney[0].blocks.count > 0 {
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
                NextDayDiaryView(journeyDate: Date())
            } label: {
                GroupBox {
                    VStack {
                        HStack(alignment: .center) {
                            Text("오늘의 일기")
                                .font(.title)
                            
                            Spacer()
                            
                            Text(currentMonthDay)
                                .font(.title2)
                                .foregroundStyle(.gray)
                        }
                        .padding(.bottom, 1)

                        HStack(alignment: .center) {
                            if currentDayJourney.count >= 1 {
                                if currentDayJourney[0].blocks.count > 0 {
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
        .padding(.top, 20)
        .padding(.horizontal, 16)
    }
    
    init() {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "M월 d일"
        self.currentMonthDay = fomatter.string(from: Date())
        self.nextMonthDay = fomatter.string(from: Date() + 86400)
        
        let nextDateId = Date.getDateId(date: Date() + 86400)
        let currentDateId = Date.getDateId(date: Date())
        
        let nextDatePredicate = #Predicate<Journey> { J in
            J.id == nextDateId
        }
        _nextDayJourney = Query(filter: nextDatePredicate)
        
        let currentDatePredicate = #Predicate<Journey> { J in
            J.id == currentDateId
        }
        
        _currentDayJourney = Query(filter: currentDatePredicate)
    }
}

