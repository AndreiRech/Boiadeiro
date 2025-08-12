import SwiftUI

struct Card: View {
    var icon: String
    var iconColor: Color
    var value: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: icon)
                .foregroundStyle(iconColor)
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .italic()
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .padding(.bottom, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(.tertiarySystemBackground))
        )
        .shadow(color: .black.opacity(0.25), radius: 16, x: 0, y: 4)
    }
}

#Preview {
    Card(icon: "chevron.up.right.2", iconColor: .green, value: "R$ 5238,29", description: "Receita estimada")
}
