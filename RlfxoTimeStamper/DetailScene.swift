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
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GifImage("DropWater")
            .frame(width: 200, height: 600)
    }
}

struct DetailScene_Previews: PreviewProvider {
    static var previews: some View {
        DetailScene(times: TimeEntity())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
