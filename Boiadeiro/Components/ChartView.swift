import SwiftUI
import SwiftData

struct ChartView: View {
    @Query(filter: #Predicate<Batch> { $0.isActive }) var activeBatches: [Batch]
    
    var batch: Batch? {
        activeBatches.first
    }
    
    private var projections: Projections? {
        if let batch = batch {
            return Projections(batch: batch)
        }
        return nil
    }
    
    private var chartCalculations: ChartCalculations? {
        if let batch = batch {
            return ChartCalculations(batch: batch, divisions: 6)
        }
        return nil
    }

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text("Gráficos")
                    .font(.title2)
                    .fontWeight(.bold)
            
                Spacer()
                
                if let batch = batch {
                    Text(batch.entryDate.formatted(date: .numeric, time: .omitted) + " - " + batch.exitDate.formatted(date: .numeric, time: .omitted))
                        .foregroundStyle(.green)
                        .font(.footnote)
                }
            }
            
            VStack(spacing: 16) {
                HStack(alignment: .top) {
                    Image(systemName: "dollarsign")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.clear)
                        .frame(width: 43, height: 43)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.clear)
                        )
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Lucro")
                        
                        if let projections = projections {
                            Text(projections.finalProfit.formatted(.currency(code: "BRL")))
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(projections.profitPercentage.formatted(.percent.precision(.fractionLength(2))))
                                .foregroundStyle(Color(.systemBackground))
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 58)
                                        .foregroundStyle(.green)
                                )
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "dollarsign")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                        .frame(width: 43, height: 43)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(Color(.secondarySystemBackground))
                        )
                }
                
                if let chartCalculations = chartCalculations {
                    let _ = chartCalculations.chartData.forEach { print($0.date, " - ", $0.value) }
                    MarkAreaChart(
                        dados: chartCalculations.chartData,
                        projection: chartCalculations.projectedWeights
                    )
                }

            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color(.tertiarySystemBackground))
            )
            .shadow(color: .black.opacity(0.25), radius: 16, x: 0, y: 4)
        }
    }
}

#Preview {
    ChartView()
}
