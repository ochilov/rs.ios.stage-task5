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
		var maxDistance = 0
		
		// drinks and food, sorted by higher scrore (distance/weight)
		let optimalSortedDrinks: [Supply] = drinks.sorted {
			$0.value/$0.weight > $1.value/$1.weight
		}
		let optimalSortedFoods: [Supply] = foods.sorted {
			$0.value/$0.weight > $1.value/$1.weight
		}
		
		// drinks and food, sorted by weight
		var weightSortedDrinks: [Supply] = drinks.sorted { $0.weight < $1.weight }
		weightSortedDrinks.insert((0, 0), at: 0)
		
		var weightSortedFoods: [Supply] = foods.sorted { $0.weight < $1.weight }
		weightSortedFoods.insert((0, 0), at: 0)
		
		// look for data and find optimal value
		for optimalDrink in optimalSortedDrinks {
			drinksLoop:
			for d in 0 ..< weightSortedDrinks.count {
				var drinkWeight = optimalDrink.weight
				var drinkDistance = optimalDrink.value
				for di in d ..< weightSortedDrinks.count {
					let drink = weightSortedDrinks[di]
					// skip same items
					if optimalDrink.weight == drink.weight && optimalDrink.value == drink.value {
						continue
					}
					drinkWeight += drink.weight
					drinkDistance += drink.value
					if drinkWeight > maxWeight {
						break drinksLoop
					}
					
					for optimalFood in optimalSortedFoods {
						foodsLoop:
						for f in 0 ..< weightSortedFoods.count {
							var foodWeight = optimalFood.weight
							var foodDistance = optimalFood.value
							for fi in f ..< weightSortedFoods.count {
								let food = weightSortedFoods[fi]
								// skip same items
								if optimalFood.weight == food.weight && optimalFood.value == food.value {
									continue
								}
								foodWeight += food.weight
								foodDistance += food.value
								if foodWeight + drinkWeight > maxWeight {
									break foodsLoop
								}
								
								let distance = min(foodDistance, drinkDistance)
								if maxDistance < distance {
									maxDistance = distance
								}
							}
						}
					}
				}
			}
		}
		
        return maxDistance
    }
}
