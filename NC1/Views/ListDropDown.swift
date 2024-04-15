//
//  ListDropDown.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/13/24.
//

import SwiftUI


//struct DropViewDelegate: DropDelegate {
//    
//    let destinationAgenda : String
//    @Binding var agendas: [String]
//    @Binding var draggedAgenda : String?
//    
//    func dropUpdated(info: DropInfo) -> DropProposal? {
//        return DropProposal(operation: .move)
//    }
//    
//    func performDrop(info: DropInfo) -> Bool {
//        draggedAgenda = nil
//        return true
//    }
//    
//    func dropEntered(info: DropInfo) {
//        if let draggedAgenda {
//            let fromIndex = agendas.firstIndex(of: draggedAgenda)
//            if let fromIndex {
//                let toIndex = agendas.firstIndex(of: destinationAgenda)
//                if let toIndex, fromIndex != toIndex {
//                    withAnimation(.default) {
//                        self.agendas.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
//                    }
//                }
//            }
//        }
//        
//        print(agendas)
//    }
//}

//struct ListDropDown: View {
//    @State var agendas: [String] = ["first", "second", "third", "fourth", "fifth"]
//    @State private var draggedAgenda: String?
//    
//    var body: some View {
//        ScrollView {
//            ForEach(agendas, id: \.self) { agenda in
//                GroupBox {
//                    Text(agenda)
//                }
//                .onDrag({
//                    self.draggedAgenda = agenda
//                    return NSItemProvider()
//                })
//                .onDrop(of: [.text], delegate: DropViewDelegate(destinationBlock: agenda, agendas: $agendas, draggedAgenda: $draggedAgenda))
//
//            }
//        }
//    }
//}
