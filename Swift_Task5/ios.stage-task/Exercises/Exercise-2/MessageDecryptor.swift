import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
		if message.count < 1 {
			return ""
		}
		var encryptedStack: [EncryptedItem] = [.init()]
		var encryptedItem = encryptedStack.first!
		var encryptedCount = ""
		for sym in message {
			// checking to numbers
			if sym.isNumber {
				encryptedCount.append(sym)
			}
			// checking to new encrypted item
			else if sym == "[" {
				encryptedStack.append(.init())
				encryptedItem = encryptedStack.last!
				encryptedItem.cryptCount = encryptedCount
				encryptedCount = ""
			}
			// checking to encrypting end
			else if sym == "]" {
				let message = encryptedItem.decrypt()
				encryptedStack.removeLast()
				if encryptedStack.isEmpty {
					// something is wrong: an extra end-symbol of the encoded text
					return ""
				}
				encryptedItem = encryptedStack.last!
				encryptedItem.cryptData.append(message)
			}
			// otherwase - message is not encryped
			else {
				encryptedItem.cryptData.append(sym)
			}
		}
		return encryptedItem.decrypt()
	}
	
	fileprivate class EncryptedItem {
		var cryptCount: String = ""
		var cryptData: String = ""
		
		var isEmpty: Bool {
			return cryptCount.isEmpty && cryptData.isEmpty
		}
		
		func empty() {
			cryptCount = "";
			cryptData = "";
		}
		
		func decrypt() -> String {
			if cryptData.isEmpty {
				return ""
			}
			
			let count = Int(cryptCount) ?? 1
			if count <= 0 {
				return ""
			}
			
			return String.init(repeating: cryptData, count: count);
		}
	}
}
