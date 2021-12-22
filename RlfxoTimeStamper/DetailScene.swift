//
//  DetailScene.swift
//  RlfxoTimeStamper
//
//  Created by 임길태 on 2021/12/16.
//

import SwiftUI

struct DetailScene: View {
    @ObservedObject var times: TimeEntity
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: TimeEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TimeEntity.insertTime, ascending: true)]) var Time: FetchedResults<TimeEntity>
    
    @State private var showEditSheet = false
    @State private var showDeleteAlert = false
    
    @State private var addTime = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if let name = times.name {
            NavigationView {
                VStack {
                    GifImage("DropWater")
                    Spacer()
                    HStack {
                    if let loadTime = times.time {
                        Text("\(loadTime/60)m : \(loadTime%60)s +")
                    }
                    Text("\(addTime/60)m : \(addTime%60)s")
                        .onReceive(timer) { time in
                            if self.addTime >= 0 {
                                self.addTime += 1
                            }
                        }
                    }
                }
                .navigationBarTitle("\(name)")
                .navigationBarItems(
                    leading: Button(action: { addTime = 0 },
                                    label: {Text("Reset")}),
                    trailing: Button(action: {
                        times.time += Int32(addTime)
                        addTime = 0
                        do {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }, label: {
                    Text("Add")
                }))
            }
        }
    }
}

struct DetailScene_Previews: PreviewProvider {
    static var previews: some View {
        DetailScene(times: TimeEntity())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
