//
//  LimitedTextField.swift
//  Boiadeiro
//
//  Created by Andrei Rech on 07/08/25.
//

import SwiftUI

struct LimitedTextField: View {
    @Binding var text: String
    
    let title: String
    let placeholder: String
    let isNumeric: Bool
    let isDisabled: Bool
    let characterLimit: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.callout)
                .fontWeight(.bold)
            
            VStack(alignment: .trailing, spacing: 0) {
                TextField(placeholder, text: Binding(
                    get: { text },
                    set: { newText in
                        var filteredText = newText
                        
                        if isNumeric {
                            filteredText = filteredText.filter { "0123456789.,".contains($0) }
                        }
                        
                        if let characterLimit = characterLimit {
                            filteredText = String(filteredText.prefix(characterLimit))
                        }
                        
                        text = filteredText
                    }
                ))
                .keyboardType(isNumeric ? .decimalPad : .default)
                .disabled(isDisabled)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(Color(.tertiarySystemBackground))
                )
                
                if let characterLimit = characterLimit {
                    Text("\(text.count)/\(characterLimit) caracteres")
                        .font(.caption)
                }
            }
        }
    }
}
