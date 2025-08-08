import Foundation
import SwiftData

@Model
final class Batch: Identifiable {
    var id = UUID()
    var name: String
    var numberOfAnimals: Int
    var entryDate: Date
    var exitDate: Date
    var entraceWeight: Double
    var aquisitionCost: Double = 10.5
    var salePrice: Double = 22.0
    var foodCost: Double = 2.0
    var totalCorpseWeight: Double?
    var aditionalEntrance: Double?
    var aditionalExit: Double?
    var isActive: Bool = false
    var createdAt: Date = Date()
    var atualWeights: [Double] = []
    
    init(id: UUID = UUID(), name: String, numberOfAnimals: Int, entryDate: Date, exitDate: Date, entraceWeight: Double, aquisitionCost: Double = 10.5, salePrice: Double = 22.0, foodCost: Double = 2.0) {
        self.id = id
        self.name = name
        self.numberOfAnimals = numberOfAnimals
        self.entryDate = entryDate
        self.exitDate = exitDate
        self.entraceWeight = entraceWeight
        self.aquisitionCost = aquisitionCost
        self.salePrice = salePrice
        self.foodCost = foodCost
    }
}
