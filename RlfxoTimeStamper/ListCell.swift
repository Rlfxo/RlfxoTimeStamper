//
//  ListCell.swift
//  RlfxoTimeStamper
//
//  Created by 임길태 on 2021/12/17.
//

import SwiftUI

struct ListCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: TimeEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TimeEntity.insertTime, ascending: true)]) var Time: FetchedResults<TimeEntity>
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Time) { times in
                    HStack {
                        Text("\(times.name!)\n\(times.insertTime!) ~ \(times.saveTime!)")
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("\((times.time)/3600)시간 \((times.time)%3600/60)분 \((times.time)%60)초")
                            .fontWeight(.medium)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let TimeEntity = Time[index]
            viewContext.delete(TimeEntity)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
