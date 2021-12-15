//
//  ContentView.swift
//  RlfxoTimeStamper
//
//  Created by 임길태 on 2021/12/15.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: TimeEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TimeEntity.insertTime, ascending: true)]) var Time: FetchedResults<TimeEntity>
    
    @State var textFieldTitle: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextField("",text: $textFieldTitle)
                    .background(Color(UIColor.secondarySystemBackground)).cornerRadius(10)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal,10)
                List {
                    ForEach(Time) { times in
                        Text("\n\(times.insertTime!,formatter: shortTimeFormatter)~\n\(times.time) second")
                    }
                    .onDelete(perform: deleteItems)
                }
                
                .listStyle(PlainListStyle())
                .navigationBarTitle("Time Stamp")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(action: addItem){
                        Label("추가",systemImage: "plus")
                    }
            )
            }
        }
    }
    
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = TimeEntity(context: viewContext)
            newItem.insertTime = Date()
            newItem.name = textFieldTitle
            textFieldTitle = ""
            
            saveItems()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let TimeEntity = Time[index]
            viewContext.delete(TimeEntity)
            
            saveItems()
        }
    }
}

private let longTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    formatter.locale = Locale(identifier: "ko-kr")
    return formatter
}()

private let shortTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    formatter.locale = Locale(identifier: "ko-kr")
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
