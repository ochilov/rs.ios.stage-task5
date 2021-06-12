import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
		if (prices.count <= 1) {
			return 0
		}
		var profit = 0
		var purchasedQuantity = 0
		var purchasedAmount   = 0
		var lastGreatPrice = 0
		// проходим цены с конца:
		// если текущая цена больше последней выгодной, то
		//    продаём всё что было куплено за последнюю выгодную цену,
		//    запоминаем текущую как выгодную и дальше ищем падение цены
		// если текущая цена равна последней выгодной, то
		//    пропускаем этот лот
		// если текущая цена меньше, то докупаем лот
		for price in prices.reversed() {
			if (price < lastGreatPrice) {
				purchasedQuantity += 1
				purchasedAmount += price
			} else if (price > lastGreatPrice) {
				profit += lastGreatPrice*purchasedQuantity - purchasedAmount
				lastGreatPrice = price
				purchasedQuantity = 0
				purchasedAmount = 0
			}
		}
		profit += lastGreatPrice*purchasedQuantity - purchasedAmount
        return profit
    }
}
