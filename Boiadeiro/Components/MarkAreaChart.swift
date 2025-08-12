import SwiftUI
import Charts

struct MarkAreaChart: View {
    @Binding var dados: [ChartValues]
    
    var body: some View {
        Chart {
            ForEach(dados) { ponto in
                AreaMark(
                    x: .value("Dia", ponto.date),
                    y: .value("Valor", ponto.value)
                )
                .foregroundStyle(Gradient(colors: [.green.opacity(0.3), .green.opacity(0.05)]))
                
                LineMark(
                    x: .value("Dia", ponto.date),
                    y: .value("Valor", ponto.value)
                )
                .lineStyle(StrokeStyle(lineWidth: 4, lineCap: .round))
                .foregroundStyle(.green)
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                AxisValueLabel(format: .dateTime.day())
            }
        }
        .chartXAxisLabel(alignment: .center) {
            Text("Dias")
                .font(.caption2)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity)
        }
        .chartYAxis {
            AxisMarks(position: .trailing)
        }
        .frame(height: 150)
    }
}
