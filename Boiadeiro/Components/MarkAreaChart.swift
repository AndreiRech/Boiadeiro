import SwiftUI
import Charts

struct MarkAreaChart: View {
    var dados: [ChartValues]
    var projection: [ChartValues]
    
    private var xDomain: ClosedRange<Double> {
            let maxDay = dados.map { $0.date }.max() ?? 0
            return 0...(maxDay > 0 ? maxDay * 1.05 : 1)
        }
    
    var body: some View {
        Chart {
            ForEach(projection) { linha in
                LineMark(
                    x: .value("Dia", linha.date),
                    y: .value("Valor", linha.value)
                )
                .foregroundStyle(by: .value("Tipo", "Projeção"))
                .lineStyle(StrokeStyle(lineWidth: 4, lineCap: .round))
            }
            
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
                .foregroundStyle(by: .value("Tipo", "Real"))
                .lineStyle(StrokeStyle(lineWidth: 4, lineCap: .round))
            }
        }
        .chartForegroundStyleScale([
            "Projeção": .orange,
            "Real": .green
        ])
        .chartForegroundStyleScale(domain: ["Projeção", "Real"], range: [.orange, .green])
        .chartXScale(domain: xDomain)
        .chartXAxis {
            AxisMarks(position: .bottom) { value in
                if let day = value.as(Double.self) {
                    AxisValueLabel(String(format: "%.0f", day))
                    AxisGridLine()
                }
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
