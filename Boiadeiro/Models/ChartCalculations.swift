import Foundation

class ChartCalculations {
    private var batch: Batch
    private var divisions: Int
    
    init(batch: Batch, divisions: Int) {
        self.batch = batch
        self.divisions = divisions
    }
    
    private var totalDays: Double {
        let totalSeconds = batch.exitDate.timeIntervalSince(batch.entryDate)
        return totalSeconds / (60 * 60 * 24)
    }
    
    var projectedWeights: [ChartValues] {
        guard divisions > 1 else { return [] }
        
        let gainPerDay = 1.3 * Double(batch.numberOfAnimals)
        
        return (0..<divisions).map { i in
            let fraction = Double(i) / Double(divisions - 1)
            let day = totalDays * fraction
            let weight = batch.entraceWeight + (gainPerDay * day)
            
            return ChartValues(date: day, value: weight)
        }
    }
    
    var chartData: [ChartValues] {
        let sortedWeights = batch.atualWeights.sorted(by: { $0.key < $1.key })

        return sortedWeights.map { (date, value) in
            let secondsSinceEntry = date.timeIntervalSince(batch.entryDate)
            let day = secondsSinceEntry / (60 * 60 * 24)

            return ChartValues(date: day, value: value)
        }
    }
}
