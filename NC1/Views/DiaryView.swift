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
    
    @Query private var nextDayJourney: [Journey]
    @Query private var currentDayJourney: [Journey]
    
    var body: some View {
        GroupBox {
            ForEach(nextDayJourney) { item in
                NavigationLink {
                    NextDayDiaryView(journey: item)
                } label: {
                    Text(String(item.id))
                }
            }
            
            Button {
                if !nextDayJourney.isEmpty {
                    print(nextDayJourney[0].blocks)
                }
            } label: {
                Text("확인")
            }
        }
        
        
        
        //            NavigationLink {
        //                NextDayDiaryView(journeyDate: Date())
        //            } label: {
        //                GroupBox {
        //                    ForEach(currentDayJourney) { item in
        //                        Text(String(item.id))
        //                    }
        //                }
        //            }
        
        .onAppear {
            if nextDayJourney.isEmpty {
                modelContext.insert(Journey(id: nextDayJourneyId, blocks: []))
            }
            
            if currentDayJourney.isEmpty {
                modelContext.insert(Journey(id: currentDayJourneyId, blocks: []))
            }
        }
        

    }
    
    init() {
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

