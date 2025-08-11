//
//  NewWeightBatch.swift
//  Boiadeiro
//
//  Created by Andrei Rech on 07/08/25.
//

import SwiftUI

struct NewWeightBatch: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var entranceWeight: String = ""
    @State private var atualWeight: String = ""
    @State private var newWeight: String = ""
    
    var batch: Batch
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                LimitedTextField(text: $entranceWeight, title: "Peso Total Entrada", placeholder: "Ex: 1234 Kg", isNumeric: true, isDisabled: true, characterLimit: nil)
                
                LimitedTextField(text: $atualWeight, title: "Peso Atual", placeholder: "Ex: 2345 Kg", isNumeric: true, isDisabled: true, characterLimit: nil)
                
                LimitedTextField(text: $newWeight, title: "Novo Peso", placeholder: "Ex: 3456 Kg", isNumeric: true, isDisabled: false, characterLimit: 10)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Nova Pesagem")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(.secondarySystemBackground), for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .background(Color(.secondarySystemBackground))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Voltar")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    let isDisabled: Bool = newWeight == ""
                    
                    Button("Salvar") {
                        if let newWeightDouble = Double(newWeight) {
                            batch.atualWeights.append(newWeightDouble)
                            try? modelContext.save()
                            dismiss()
                        }
                    }
                    .disabled(isDisabled)
                }
            }
            .onAppear {
                entranceWeight = String(format: "%.1f Kg", batch.entraceWeight)
                atualWeight = String(format: "%.1f Kg", batch.atualWeights.last ?? batch.entraceWeight)
            }
        }
    }
}

#Preview {
    NewWeightBatch(batch: Batch(name: "Nelore", numberOfAnimals: 10, entryDate: Date(), exitDate: Date()+90, entraceWeight: 1234))
}
