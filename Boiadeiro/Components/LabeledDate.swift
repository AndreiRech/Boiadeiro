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
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.callout)
                .fontWeight(.bold)
            
            DatePicker("", selection: $date, displayedComponents: [.date])
                .labelsHidden()
                .disabled(isDisabled)
        }
    }
}
