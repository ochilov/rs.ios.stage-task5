import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
		let drinkKnapsackTable = knapsackTable(for: drinks)
		let foodsKnapsackTable = knapsackTable(for: foods)
		
		let drinkMaxDistances = drinkKnapsackTable[drinks.count]
		let foodsMaxDistances = foodsKnapsackTable[foods.count]
		
		var maxDistance = 0
		for weigth in 1 ..< maxWeight {
			let maxDistanceWithDrink = drinkMaxDistances[weigth]
			let maxDistanceWithFoods = foodsMaxDistances[maxWeight - weigth]
			let availableMaxDistance = min(maxDistanceWithDrink, maxDistanceWithFoods)
			if maxDistance < availableMaxDistance {
				maxDistance = availableMaxDistance
			}
		}

		return maxDistance
    }
	
	func knapsackTable(for supplies: [Supply]) -> [[Int]] {
		// init knapsack table with zeros
		var knapsackTable = Array.init(
			repeating: Array.init(repeating: 0, count: maxWeight+1),
			count: supplies.count+1)
		
		for i in 1 ... supplies.count {
			for j in 1 ... maxWeight {
				if supplies[i-1].weight > j {
					// not feet, take values from pre row
					knapsackTable[i][j] = knapsackTable[i-1][j]
				} else {
					knapsackTable[i][j] = max(
						supplies[i-1].value + knapsackTable[i-1][j-supplies[i-1].weight],
						knapsackTable[i-1][j]
					)
				}
			}
		}
		
		return knapsackTable
	}
}
