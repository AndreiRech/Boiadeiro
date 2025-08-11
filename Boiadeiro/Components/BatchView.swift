//
//  BatchView.swift
//  Boiadeiro
//
//  Created by Andrei Rech on 06/08/25.
//

import SwiftUI

struct BatchView: View {
    var batch: Batch
    
    @State private var isActive = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Button {
                isActive.toggle()
                batch.isActive.toggle()
            } label: {
                Image(systemName: batch.isActive ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(batch.isActive ? .green : Color(.systemGray3))
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(batch.name)
                    .foregroundStyle(.primary)
                
                Text(batch.createdAt.formatted(date: .numeric, time: .omitted))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.green)
                .frame(width: 12, height: 16)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .onAppear {
            isActive = batch.isActive
        }
    }
}

#Preview {
    BatchView(batch: Batch(name: "Nelore", numberOfAnimals: 10, entryDate: Date(), exitDate: Date()+90, entraceWeight: 1234))
}
