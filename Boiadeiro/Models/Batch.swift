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
    
    init(
        id: UUID = UUID(),
        name: String,
        numberOfAnimals: Int,
        entryDate: Date,
        exitDate: Date? = nil,
        entraceWeight: Double,
        aquisitionCost: Double? = nil,
        salePrice: Double? = nil,
        foodCost: Double? = nil
    ) {
        let defaultAquisitionCost = 10.5
        let defaultSalePrice = 22.0
        let defaultFoodCost = 2.0
        
        let finalExitDate = exitDate ?? Calendar.current.date(byAdding: .day, value: 90, to: entryDate) ?? entryDate
        
        self.id = id
        self.name = name
        self.numberOfAnimals = numberOfAnimals
        self.entryDate = entryDate
        self.exitDate = finalExitDate
        self.entraceWeight = entraceWeight
        self.aquisitionCost = aquisitionCost ?? defaultAquisitionCost
        self.salePrice = salePrice ?? defaultSalePrice
        self.foodCost = foodCost ?? defaultFoodCost
    }
}

