//
//  ListCell.swift
//  RlfxoTimeStamper
//
//  Created by 임길태 on 2021/12/17.
//

import SwiftUI

struct ListCell: View {
    @EnvironmentObject var DateForm: DateFormatter
    @EnvironmentObject var RelativeForm: RelativeDateTimeFormatter
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: TimeEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TimeEntity.insertTime, ascending: true)]) var Time: FetchedResults<TimeEntity>
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Time) { times in
                    HStack {
                        Text("\(times.name!)\n\(times.insertTime!,formatter: self.DateForm) ~ \(times.saveTime!,formatter: self.RelativeForm)")
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
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DateFormatter.shortTimeFormatter)
            .environmentObject(RelativeDateTimeFormatter.relativeTimeFormatter)
    }
}
