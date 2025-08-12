import Foundation

class Projections {
    private var batch: Batch
    
    // MARK: - Auxiliares
    private var numberOfAnimals: Double
    private var totalDays: Double
    
    // MARK: - Pesos - Total e médio
    var meanInitialWeight: Double { // peso total inicial / quantidade
        self.batch.entraceWeight / self.numberOfAnimals
    }

    var meanFinalWeight: Double { // peso total final / quantidade
        let total = self.batch.atualWeights.last
            ?? self.batch.entraceWeight * 1.5 * self.totalDays
        return total / self.numberOfAnimals
    }
    
    var meanCorpseWeight: Double { // peso total carcaça / quantidade
        let total = self.batch.totalCorpseWeight
            ?? (self.batch.atualWeights.last ?? self.batch.entraceWeight) / 2
        return total / self.numberOfAnimals
    }
    
    // MARK: - Valores Compra - unitario, total
    var unitValue: Double { // compra * peso medio
        self.batch.aquisitionCost * self.meanInitialWeight
    }
    
    var totalValue: Double { // valor unitario * quantidade
        self.unitValue * self.numberOfAnimals
    }
    
    // MARK: - Valores Venda - unitario, total
    var unitSellingPrice: Double { // peso médio carcaça * valor kg
        self.meanCorpseWeight * self.batch.salePrice
    }
    
    var totalSellingPrice: Double { // preço de venda unitario * quantidade
        self.unitSellingPrice * self.numberOfAnimals
    }
    
    // MARK: - Consumo - diário, animal, lote
    var kgConsumption: Double { // peso médio vivo * 2,2%
        self.meanInitialWeight * 2.55 / 100
    }
    
    var dailyConsumption: Double { // custo ração * consumo de kg/dia
        self.batch.foodCost * self.kgConsumption
    }
    
    var animalConsumption: Double { // cosumo diário * dias
        self.dailyConsumption * self.totalDays
    }
    
    var totalConsumption: Double { // consumo dos animais * quantidade
        self.animalConsumption * self.numberOfAnimals
    }
    
    // MARK: - Totais - receita, despesas, final
    var totalRevenue: Double { // preço de venda total + receitas adicionais
        self.totalSellingPrice + (self.batch.aditionalEntrance ?? 0.0)
    }
    
    var totalExpenses: Double { // consumo total + preco de compra total + despesas adicionais
        self.totalConsumption + self.totalValue + (self.batch.aditionalExit ?? 0.0)
    }
    
    var finalProfit: Double { // receita - despesas
        self.totalRevenue - self.totalExpenses
    }
    
    var profitPercentage: Double { // receita / despesas
        self.totalRevenue / self.totalExpenses
    }
    
    init(batch: Batch) {
        self.batch = batch
        self.numberOfAnimals = Double(batch.numberOfAnimals)
        
        let seconds = batch.entryDate.distance(to: batch.exitDate)
        self.totalDays = seconds / (60 * 60 * 24)
    }
}
