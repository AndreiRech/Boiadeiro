//
//  ViewBatch.swift
//  Boiadeiro
//
//  Created by Andrei Rech on 08/08/25.
//

import SwiftUI

struct ViewBatch: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name: String = ""
    @State private var numberOfAnimals: String = ""
    @State private var entryDate: Date = Date()
    @State private var exitDate: Date = Date()
    @State private var entranceWeight: String = ""
    @State private var aquisitionCost: String = ""
    @State private var salePrice: String = ""
    @State private var foodCost: String = ""
    @State private var atualWeight: String = ""
    @State private var totalCorpseWeight: String = ""
    @State private var aditionalEntrance: String = ""
    @State private var aditionalExit: String = ""
    
    @State var addNewWeight: Bool = false
    @State var editBatch: Bool = false
    
    var batch: Batch
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                BatchFields(
                    name: $name,
                    numberOfAnimals: $numberOfAnimals,
                    entryDate: $entryDate,
                    exitDate: $exitDate,
                    entranceWeight: $entranceWeight,
                    aquisitionCost: $aquisitionCost,
                    salePrice: $salePrice,
                    foodCost: $foodCost,
                    atualWeight: $atualWeight,
                    totalCorpseWeight: $totalCorpseWeight,
                    aditionalEntrance: $aditionalEntrance,
                    aditionalExit: $aditionalExit,
                    showExtraFields: true,
                    isReadOnly: true
                )
                
                Button {
                    addNewWeight.toggle()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                        
                        Text("Nova Pesagem")
                    }
                    .foregroundColor(Color(.systemBackground))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.green)
                )
                .padding(.top, 16)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color(.secondarySystemBackground), for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .background(Color(.secondarySystemBackground))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        editBatch.toggle()
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
                
                ToolbarItem(placement: .destructiveAction) {
                    Button {
                        modelContext.delete(batch)
                        try? modelContext.save()
                        dismiss()
                    } label: {
                        Image(systemName: "trash.circle.fill")
                            .foregroundStyle(.red)
                    }
                }
            }
            .onAppear {
                self.name = batch.name
                self.numberOfAnimals = String(batch.numberOfAnimals)
                self.entryDate = batch.entryDate
                self.exitDate = batch.exitDate
                self.entranceWeight = String(batch.entraceWeight)
                self.aquisitionCost = String(batch.aquisitionCost)
                self.salePrice = String(batch.salePrice)
                self.foodCost = String(batch.foodCost)
                
                self.atualWeight = String(batch.atualWeights.last ?? batch.entraceWeight)
                self.totalCorpseWeight = String(batch.totalCorpseWeight ?? 0)
                self.aditionalEntrance = String(batch.aditionalEntrance ?? 0)
                self.aditionalExit = String(batch.aditionalExit ?? 0)
            }
            .sheet(isPresented: $addNewWeight) {
                NewWeightBatch(batch: batch)
            }
            .sheet(isPresented: $editBatch, onDismiss: {
                try? modelContext.save()
            }) {
                UseBatch(batch: batch)
            }
        }
    }
}

#Preview {
    ViewBatch(batch: Batch(name: "Nelore", numberOfAnimals: 10, entryDate: Date(), exitDate: Date()+90, entraceWeight: 1234))
}
