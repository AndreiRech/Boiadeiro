import SwiftUI

struct ViewBatch: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var addNewWeight: Bool = false
    @State var editBatch: Bool = false
    
    var batch: Batch
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                BatchFields(
                    name: .constant(batch.name),
                    numberOfAnimals: .constant(String(batch.numberOfAnimals)),
                    entryDate: .constant(batch.entryDate),
                    exitDate: .constant(batch.exitDate),
                    entranceWeight: .constant(String(batch.entraceWeight)),
                    aquisitionCost: .constant(String(batch.aquisitionCost)),
                    salePrice: .constant(String(batch.salePrice)),
                    foodCost: .constant(String(batch.foodCost)),
                    atualWeight: .constant(String(batch.atualWeights.last ?? batch.entraceWeight)),
                    totalCorpseWeight: .constant(String(batch.totalCorpseWeight ?? 0)),
                    aditionalEntrance: .constant(String(batch.aditionalEntrance ?? 0)),
                    aditionalExit: .constant(String(batch.aditionalExit ?? 0)),
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
            .navigationTitle(batch.name)
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
            .sheet(isPresented: $addNewWeight) {
                NewWeightBatch(batch: batch)
            }
            .sheet(isPresented: $editBatch) {
                UseBatch(batch: batch)
            }
        }
    }
}

#Preview {
    ViewBatch(batch: Batch(name: "Nelore", numberOfAnimals: 10, entryDate: Date(), exitDate: Date()+90, entraceWeight: 1234))
}
