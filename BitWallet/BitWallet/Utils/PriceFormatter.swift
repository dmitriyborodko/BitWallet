import Foundation

struct PriceFormatter {

    private static let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    }()

    static func format(price priceString: String, precision: Int?, currencySymbol: String? = "€") -> String? {
        let precision = precision ?? priceString.split(separator: ".").last?.count
        return Double(priceString).flatMap { format(price: $0, precision: precision, currencySymbol: currencySymbol) }
    }

    static func format(price: Double, precision: Int?, currencySymbol: String? = "€") -> String? {
        currencyFormatter.locale = Locale.current
        currencyFormatter.currencySymbol = currencySymbol

        currencyFormatter.minimumFractionDigits = precision ?? 0
        currencyFormatter.maximumFractionDigits = precision ?? Int.max

        return currencyFormatter.string(from: NSNumber(value: price))
    }
}
