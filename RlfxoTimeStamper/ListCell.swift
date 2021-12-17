//
//  ListCell.swift
//  RlfxoTimeStamper
//
//  Created by 임길태 on 2021/12/17.
//

import SwiftUI

struct ListCell: View {
    @ObservedObject var times: TimeEntity
    
    @EnvironmentObject var DateForm: DateFormatter
    @EnvironmentObject var RelativeForm: RelativeDateTimeFormatter
    
    var body: some View {
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
}

