//
//  LabeledDate.swift
//  Boiadeiro
//
//  Created by Andrei Rech on 07/08/25.
//

import SwiftUI

struct LabeledDate: View {
    @Binding var date: Date
    
    let title: String
    let isDisabled: Bool
    
    var body: some View {
        HStack() {
            Text(title)
                .font(.callout)
                .fontWeight(.bold)
            
            Spacer()
            
            DatePicker("", selection: $date, displayedComponents: [.date])
                .labelsHidden()
                .disabled(isDisabled)
        }
    }
}
