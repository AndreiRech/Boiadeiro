import SwiftUI

struct BatchesEmptyState: View {
    @Binding var addBatch: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 16) {
                Image(.cowEmpty)
                    .resizable()
                    .frame(width: 142, height: 187)
                
                VStack(spacing: 4) {
                    Text("Ainda não há nenhum lote")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Text("Adicione um lote para saber quais são seus detalhes!")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .foregroundStyle(.primary)
                }
            }
            
            Spacer()
            
            Button {
                addBatch.toggle()
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "plus")
            
                    Text("Adicionar Lote")
                }
                .foregroundColor(Color(.systemBackground))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.green)
            )
        }
        .padding(.horizontal, 48)
    }
}

#Preview {
    BatchesEmptyState(addBatch: .constant(true))
}
