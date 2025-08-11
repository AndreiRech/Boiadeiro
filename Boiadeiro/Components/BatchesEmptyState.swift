import SwiftUI

struct BatchesEmptyState: View {
    @Binding var addBatch: Bool
    
    let title: String
    let description: String
    let buttonText: String?
    let buttonImage: String?
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 16) {
                Image(.cowEmpty)
                    .resizable()
                    .frame(width: 142, height: 187)
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Text(description)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .foregroundStyle(.primary)
                }
            }
            
            Spacer()
            
            if let buttonText = buttonText, let buttonImage = buttonImage {
                Button {
                    addBatch.toggle()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: buttonImage)
                
                        Text(buttonText)
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
        }
        .padding(.horizontal, 48)
    }
}
