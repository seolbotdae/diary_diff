//
//  DiaryView.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/14/24.
//

import SwiftUI

struct DiaryView: View {
    let tomorrow = Date() + 86400
    let today = Date()
    
    @State var dateFormatter: DateFormatter = DateFormatter()
    
    @State var tomorrowDateString: String = ""
    @State var todayDateString: String = ""
    
    var body: some View {
        VStack {
            NavigationLink {
                NextDayDiaryView(journeyDate: tomorrow)
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
                            Text("잠은 다잤네")
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
                            Text("잠은 다잤네")
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
        }
        .padding(.top, 20)
        .padding(.horizontal, 16)
    }
    
    init() {
        let nextDateId = Date.getDateId(date: Date() + 86400)
        let currentDateId = Date.getDateId(date: Date())
    }
}

