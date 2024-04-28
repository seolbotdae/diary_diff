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
    
    let tomorrowDate = Date() + 86400
    let todayDate = Date()
    
    let MDDateFormatter = Date.getDateFormatter(format: "M월 d일")
    
    @State var tomorrowJourney: Journey?
    @State var todayJourney: Journey?

    @State var temp: Bool = false
    
    var body: some View {
        VStack {
            NavigationLink {
//                DayDiaryView(journeyDate: tomorrow)
//                NextDayDiaryView(journeyDate: tomorrow)
            } label: {
                GroupBox {
                    VStack {
                        HStack(alignment: .center) {
                            Text("내일의 일기")
                                .font(.title)
                            
                            Spacer()
                            
                            Text(MDDateFormatter.string(from: tomorrowDate))
                                .font(.title2)
                                .foregroundStyle(.gray)
                        }
                        .padding(.bottom, 1)

                        HStack(alignment: .center) {
                            if let target = tomorrowJourney {
                                if target.blocks.isEmpty {
                                    Text("아직 일기를 작성하지 않았습니다.")
                                } else {
                                    Text("작성된 일기가 있습니다. 내일 확인해 보세요!")
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
//                DayDiaryView(journeyDate: today)
            } label: {
                GroupBox {
                    VStack {
                        HStack(alignment: .center) {
                            Text("오늘의 일기")
                                .font(.title)
                            
                            Spacer()
                            
                            Text(MDDateFormatter.string(from: todayDate))
                                .font(.title2)
                                .foregroundStyle(.gray)
                        }
                        .padding(.bottom, 1)

                        HStack(alignment: .center) {
                            if let target = todayJourney {
                                if target.blocks.isEmpty {
                                    Text("아직 일기를 작성하지 않았습니다.")
                                } else {
                                    Text("작성된 일기가 있습니다. 내일 확인해 보세요!")
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
            tomorrowJourney = fetchJourney(id: Date.getParsedDate(date: tomorrowDate))
            todayJourney = fetchJourney(id: Date.getParsedDate(date: todayDate))

            if tomorrowJourney == nil {
                let newJourney = Journey(id: Date.getParsedDate(date: tomorrowDate))
                modelContext.insert(newJourney)
                tomorrowJourney = fetchJourney(id: Date.getParsedDate(date: tomorrowDate))
            }
            
            if todayJourney == nil {
                let newJourney = Journey(id: Date.getParsedDate(date: todayDate))
                modelContext.insert(newJourney)
                todayJourney = fetchJourney(id: Date.getParsedDate(date: todayDate))
            }
            
            print(tomorrowJourney!.id)
            print(todayJourney!.id)
        }
        .padding(.top, 20)
        .padding(.horizontal, 16)
    }

    func fetchJourney(id: ParsedDate) -> Journey? {
        do {
            let predicate = #Predicate<Journey> { $0.id == id }
            
            let descriptor = FetchDescriptor(predicate: predicate)
            
            let journeys = try modelContext.fetch(descriptor)
            
            if !journeys.isEmpty {
                return journeys[0]
            } else {
                return nil
            }
        } catch {
            print("none!")
        }
        
        return nil
    }
}

