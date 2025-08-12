//
//  Statistics.swift
//  Boiadeiro
//
//  Created by Andrei Rech on 06/08/25.
//

import SwiftUI
import SwiftData

struct Statistics: View {
    @Query(filter: #Predicate<Batch> { $0.isActive }) var activeBatches: [Batch]
    
    @Binding var selectedTab: Int
    @State private var selectBatch: Bool = false
    
    private var batch: Batch? {
        activeBatches.first
    }
    
    private var projections: Projections? {
        if let batch = batch {
            return Projections(batch: batch)
        }
        return nil
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if let projections = projections {
                HStack(spacing: 16) {
                    Card(icon: "chevron.up.right.2", iconColor: .green, value: projections.totalRevenue.formatted(.currency(code: "BRL")), description: "Receita estimada")
                    Card(icon: "chevron.down.right.2", iconColor: .orange, value: projections.totalExpenses.formatted(.currency(code: "BRL")), description: "Despesa estimada")
                }
                
                HStack(spacing: 16) {
                    Card(icon: "dumbbell.fill", iconColor: .green, value: projections.meanFinalWeight.formatted(.number), description: "Peso Médio estimado")
                    Card(icon: "percent", iconColor: .green, value: projections.profitPercentage.formatted(.percent), description: "Crescimento")
                }
                
                ChartView()
                
                Spacer()
            } else {
                BatchesEmptyState(addBatch: $selectBatch, title: "Nenhum lote selecionado", description: "Selecione um lote para saber suas estatísticas!", buttonText: "Selecionar Lote", buttonImage: "checkmark.circle.fill")
                    .padding(.top, 64)
                    .padding(.bottom, 40)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .navigationTitle("Estatísticas")
        .background(Color(.secondarySystemBackground))
        .toolbarBackground(Color(.secondarySystemBackground), for: .navigationBar)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .onChange(of: selectBatch) {
            selectedTab = 0
        }
    }
}

#Preview {
    TabBar()
}
