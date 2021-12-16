//
//  ComposeScene.swift
//  RlfxoTimeStamper
//
//  Created by 임길태 on 2021/12/16.
//

import SwiftUI

struct ComposeScene: View {
    @State private var title: String = ""
    @Binding var showComposer: Bool
    
    var body: some View {
        Text("composer")
    }
}

struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene(showComposer: .constant(false))
    }
}
