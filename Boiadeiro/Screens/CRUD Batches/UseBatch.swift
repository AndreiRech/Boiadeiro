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
                    let isDisabled: Bool = name == ""
                    || numberOfAnimals == ""
                    || entranceWeight == ""
                    || aquisitionCost == ""
                    || salePrice == ""
                    || foodCost == ""
                    
                    Button("Salvar") {
                        if let newNumberOfAnimals = Int(numberOfAnimals),
                           let newEntranceWeight = Double(entranceWeight.replacingOccurrences(of: ",", with: ".")),
                           let newAquisitionCost = Double(aquisitionCost.replacingOccurrences(of: ",", with: ".")),
                           let newSalePrice = Double(salePrice.replacingOccurrences(of: ",", with: ".")),
                           let newFoodCost = Double(foodCost.replacingOccurrences(of: ",", with: ".")) {
                            let batch = Batch(id: UUID(), name: self.name, numberOfAnimals: newNumberOfAnimals, entryDate: entryDate, exitDate: exitDate == entryDate ? exitDate+90 : exitDate, entraceWeight: newEntranceWeight, aquisitionCost: newAquisitionCost, salePrice: newSalePrice, foodCost: newFoodCost)
                            modelContext.insert(batch)
                            try? modelContext.save()
                            dismiss()
                        }
                    }
                    .disabled(isDisabled)
                    .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    UseBatch()
}
