import SwiftUI
import SwiftData

struct Batches: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var batches: [Batch]
    
    @State var addBatch: Bool = false
    @State var searchText = ""
    @State var navigateToBatch: Batch?
    
    var filteredBatches: [Batch] {
        if searchText.isEmpty {
            return batches
        } else {
            return batches.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            if batches.isEmpty {
                BatchesEmptyState(addBatch: $addBatch, title: "Ainda não há nenhum lote", description: "Adicione um lote para saber quais são seus detalhes!", buttonText: "Adicionar Lote", buttonImage: "plus")
                    .padding(.top, 64)
                    .padding(.bottom, 40)
//            } else if filteredBatches.isEmpty {
//                BatchesEmptyState(addBatch: $addBatch, title: "Nenhum lote filtrado", description: "Pesquise por outro nome de lote para encontrá-lo rapidamente!", buttonText: nil, buttonImage: nil)
//                    .padding(.top, 64)
//                    .padding(.bottom, 40)
//                    .searchable(text: $searchText, prompt: "Buscar lotes")
            } else {
                List(filteredBatches) { batch in
                    BatchView(batch: batch)
                    .listRowInsets(EdgeInsets())
                    .background(Color(.tertiarySystemBackground))
                    .swipeActions(edge: .trailing) {
                        Button("Excluir", systemImage: "trash", role: .destructive) {
                            modelContext.delete(batch)
                        }
                    }
                    .onTapGesture { navigateToBatch = batch }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
                .searchable(text: $searchText, prompt: "Buscar lotes")
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 1) // wtf
        .navigationTitle("Lotes")
        .background(Color(.secondarySystemBackground))
        .toolbarBackground(Color(.secondarySystemBackground), for: .navigationBar)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .toolbarBackground(Color(.secondarySystemBackground), for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    addBatch.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $addBatch) {
            UseBatch()
        }
        .navigationDestination(item: $navigateToBatch) { batch in
            ViewBatch(batch: batch)
        }
    }
}

#Preview {
    TabBar()
}
