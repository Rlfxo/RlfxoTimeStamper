//
//  ComposeScene.swift
//  RlfxoTimeStamper
//
//  Created by 임길태 on 2021/12/16.
//

import SwiftUI

struct ComposeScene: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: TimeEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TimeEntity.insertTime, ascending: true)]) var Time: FetchedResults<TimeEntity>
    
    @State  var title: String = ""
    @Binding var showComposer: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Image("test image")
                    .resizable()
                    .frame(width: 100, height: 100)
                TextField("",text: $title)
                    .frame(height:50)
                    .background(Color(UIColor.secondarySystemBackground)).cornerRadius(10)
                    .frame(maxWidth: .infinity)
                .padding(.horizontal,10)
                
                Text("Notice\n\nWhen you are courting a nice girl an hour seems like a second. When you sit on a red-hot cinder a second seems like an hour. That's relativity. -Albert Einstein\nAll that is straight lies. All truth is crooked; time itself is a circle. -Friedrich Nietzsche\nPrediction is very difficult, especially about the future. -Niels Bohr\nNever let the future disturb you. You will meet it, if you have to, with the same weapons of reason which today arm you against the present. -Marcus Aurelius Antoninus\nEmploy thy time well, if thou meanest to get leisure. -Benjamin Franklin\nTime is the coin of your life. It is the only coin you have, and only you can determine how it will be spent. Be careful lest you let other people spend it for you. -Carl Sandburg\nPlease, use it carefully. -Me")
                    .multilineTextAlignment(.leading)
                    .padding(.leading,10)
                    .font(.system(size: 14, weight: .medium,design:.rounded))
            }
            .navigationBarTitle("New Stamp", displayMode: .inline)
            .navigationBarItems(leading: DismissButton(show: $showComposer),trailing: SaveButton(show: $showComposer, title: $title))
        }
    }
}

fileprivate struct DismissButton: View {
    @Binding var show: Bool
    var body: some View {
        Button(action: {
            self.show = false
        }, label: {
            Text("Cancel")
        })
    }
}

fileprivate struct SaveButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var show: Bool
    @Binding var title: String
    
    var body: some View {
        Button(action: {
            
            
            
            self.show = false
        }, label: {
            Text("Save")
        })
    }
}

struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene(showComposer: .constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
