import SwiftUI
import SwiftData

struct ChartView: View {
    @Query(filter: #Predicate<Batch> { $0.isActive }) var activeBatches: [Batch]

    var batch: Batch? {
        activeBatches.first
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
                        
                        Text("R$4893,23")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("+12,45%")
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
                
                MarkAreaChart(dados: .constant([
                            ChartValues(date: Date().addingTimeInterval(-5*24*60*60), value: 10),
                            ChartValues(date: Date().addingTimeInterval(-4*24*60*60), value: 30),
                            ChartValues(date: Date().addingTimeInterval(-3*24*60*60), value: 25),
                            ChartValues(date: Date().addingTimeInterval(-2*24*60*60), value: 40),
                            ChartValues(date: Date().addingTimeInterval(-1*24*60*60), value: 15),
                            ChartValues(date: Date(), value: 50),
                        ]))
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
