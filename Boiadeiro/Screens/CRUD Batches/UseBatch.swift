import SwiftUI

struct UseBatch: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    // Base States
    @State private var name: String = ""
    @State private var numberOfAnimals: String = ""
    @State private var entryDate: Date = Date()
    @State private var exitDate: Date = Date()
    @State private var entranceWeight: String = ""
    @State private var aquisitionCost: String = ""
    @State private var salePrice: String = ""
    @State private var foodCost: String = ""
    
    // Edit States
    @State private var atualWeight: String = ""
    @State private var totalCorpseWeight: String = ""
    @State private var aditionalEntrance: String = ""
    @State private var aditionalExit: String = ""
    @State private var latestWeightDate: Date? = nil
    
    var batch: Batch?
    var isEditing: Bool { batch != nil }
    
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
                    showExtraFields: isEditing,
                    isReadOnly: false
                )
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(isEditing ? "Editar" : "Criar")
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
                    var isDisabled: Bool {
                        if isEditing {
                            return name.isEmpty
                            || numberOfAnimals.isEmpty
                            || entranceWeight.isEmpty
                            || aquisitionCost.isEmpty
                            || salePrice.isEmpty
                            || foodCost.isEmpty
                            || atualWeight.isEmpty
                            || totalCorpseWeight.isEmpty
                            || aditionalEntrance.isEmpty
                            || aditionalExit.isEmpty
                        } else {
                            return name.isEmpty
                            || numberOfAnimals.isEmpty
                            || entranceWeight.isEmpty
                        }
                    }
                    
                    Button("Salvar") {
                        if let newNumberOfAnimals = Int(numberOfAnimals),
                           let newEntranceWeight = entranceWeight.toDouble {
                            
                            if let batch,
                               let newAquisitionCost = aquisitionCost.toDouble,
                               let newSalePrice = salePrice.toDouble,
                               let newFoodCost = foodCost.toDouble,
                               let newAtualWeight = atualWeight.toDouble,
                               let newTotalCorpseWeight = totalCorpseWeight.toDouble,
                               let newAditionalEntrance = aditionalEntrance.toDouble,
                               let newAditionalExit = aditionalExit.toDouble {
                                
                                batch.name = self.name
                                batch.numberOfAnimals = newNumberOfAnimals
                                batch.entryDate = self.entryDate
                                batch.exitDate = self.exitDate
                                batch.entraceWeight = newEntranceWeight
                                batch.aquisitionCost = newAquisitionCost
                                batch.salePrice = newSalePrice
                                batch.foodCost = newFoodCost
                                batch.atualWeights.updateValue(newAtualWeight, forKey: self.latestWeightDate ?? Date())
                                batch.totalCorpseWeight = newTotalCorpseWeight
                                batch.aditionalEntrance = newAditionalEntrance
                                batch.aditionalExit = newAditionalExit
                            } else {
                                let newBatch = Batch(
                                    name: self.name,
                                    numberOfAnimals: newNumberOfAnimals,
                                    entryDate: self.entryDate,
                                    exitDate: self.exitDate,
                                    entraceWeight: newEntranceWeight,
                                    aquisitionCost: aquisitionCost.isEmpty ? nil : aquisitionCost.toDouble,
                                    salePrice: salePrice.isEmpty ? nil : salePrice.toDouble,
                                    foodCost: foodCost.isEmpty ? nil : foodCost.toDouble
                                )
                                
                                modelContext.insert(newBatch)
                                try? modelContext.save()
                            }
                            dismiss()
                        }
                        
                    }
                    .disabled(isDisabled)
                    .fontWeight(.bold)
                }
            }
            .onAppear {
                guard let batch = self.batch else { return }
                
                self.name = batch.name
                self.numberOfAnimals = String(batch.numberOfAnimals)
                self.entryDate = batch.entryDate
                self.exitDate = batch.exitDate
                self.entranceWeight = String(batch.entraceWeight)
                self.aquisitionCost = String(batch.aquisitionCost)
                self.salePrice = String(batch.salePrice)
                self.foodCost = String(batch.foodCost)
                self.atualWeight = String(batch.atualWeights.sorted(by: { $0.key > $1.key }).first?.value ?? batch.entraceWeight)
                self.totalCorpseWeight = String(batch.totalCorpseWeight ?? 0)
                self.aditionalEntrance = String(batch.aditionalEntrance ?? 0)
                self.aditionalExit = String(batch.aditionalExit ?? 0)
                
                if let latestEntry = batch.atualWeights.sorted(by: { $0.key > $1.key }).first {
                    self.atualWeight = String(latestEntry.value)
                    self.latestWeightDate = latestEntry.key
                } else {
                    self.atualWeight = String(batch.entraceWeight)
                }
            }
        }
    }
}

#Preview {
    UseBatch()
}
