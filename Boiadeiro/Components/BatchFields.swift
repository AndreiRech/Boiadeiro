//
//  BatchFields.swift
//  Boiadeiro
//
//  Created by Andrei Rech on 08/08/25.
//

import SwiftUI

struct BatchFields: View {
    // Base States
    @Binding var name: String
    @Binding var numberOfAnimals: String
    @Binding var entryDate: Date
    @Binding var exitDate: Date
    @Binding var entranceWeight: String
    @Binding var aquisitionCost: String
    @Binding var salePrice: String
    @Binding var foodCost: String
    
    // Edit States
    @Binding var atualWeight: String
    @Binding var totalCorpseWeight: String
    @Binding var aditionalEntrance: String
    @Binding var aditionalExit: String
    
    var showExtraFields: Bool
    var isReadOnly: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            LimitedTextField(text: $name, title: "Nome do Lote", placeholder: "Ex: Lote Abril", isNumeric: false, isDisabled: isReadOnly, characterLimit: 20)
            
            LimitedTextField(text: $numberOfAnimals, title: "Número de Animais", placeholder: "Ex: 12", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
            
            HStack(spacing: 16) {
                LabeledDate(date: $entryDate, title: "Data Entrada", isDisabled: isReadOnly)
                
                LabeledDate(date: $exitDate, title: "Data Saída", isDisabled: isReadOnly)
                
            }
            
            if showExtraFields {
                HStack(spacing: 16) {
                    LimitedTextField(text: $entranceWeight, title: "Peso total Entrada", placeholder: "Ex: 1234 Kg", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
                    
                    LimitedTextField(text: $atualWeight, title: "Peso Atual", placeholder: "Ex: 2345 Kg", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
                }
            } else {
                LimitedTextField(text: $entranceWeight, title: "Peso total Entrada", placeholder: "Ex: 1234 Kg", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
            }
            
            HStack(spacing: 16) {
                LimitedTextField(text: $aquisitionCost, title: "Valor Aquisição", placeholder: "Ex: R$10,5 / Kg", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
                
                LimitedTextField(text: $salePrice, title: "Valor Venda", placeholder: "Ex: R$22,0 / Kg", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
            }
            
            if showExtraFields {
                HStack(spacing: 16) {
                    LimitedTextField(text: $foodCost, title: "Custo Aliment. p/Kg", placeholder: "Ex: R$1,67 / Kg", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
                    
                    LimitedTextField(text: $totalCorpseWeight, title: "Peso total Carcaça", placeholder: "Ex: 1145 Kg", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
                }
            } else {
                LimitedTextField(text: $foodCost, title: "Custo Aliment. p/Kg", placeholder: "Ex: R$1,67 / Kg", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
            }
            
            if showExtraFields {
                HStack(spacing: 16) {
                    LimitedTextField(text: $aditionalEntrance, title: "Entradas Adicionais", placeholder: "Ex: R$1000,0", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
                    
                    LimitedTextField(text: $aditionalExit, title: "Saídas Adicionais", placeholder: "Ex: R$500,0 Kg", isNumeric: true, isDisabled: isReadOnly, characterLimit: 10)
                }
            }
        }
    }
}
