//
//  DetailScene.swift
//  RlfxoTimeStamper
//
//  Created by 임길태 on 2021/12/16.
//

import SwiftUI

struct DetailScene: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: TimeEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TimeEntity.insertTime, ascending: true)]) var Time: FetchedResults<TimeEntity>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailScene_Previews: PreviewProvider {
    static var previews: some View {
        DetailScene().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
