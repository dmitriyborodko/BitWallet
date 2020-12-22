import Foundation

extension Collection {

    func contains(index: Index) -> Bool {
        return ((index >= startIndex) && (index < endIndex))
    }

    subscript(safe index: Index) -> Element? {
        return contains(index: index) ? self[index] : nil
    }
}
