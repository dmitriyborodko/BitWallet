import Foundation

struct PriceFormatter {

    private static let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    }()

    static func format(price priceString: String, precision: Int?, currencySymbol: String? = "€") -> String? {
        return Double(priceString).flatMap { format(price: $0, precision: precision, currencySymbol: currencySymbol) }
    }

    static func format(price: Double, precision: Int?, currencySymbol: String? = "€") -> String? {
        currencyFormatter.locale = Locale.current
        currencyFormatter.currencySymbol = currencySymbol

        if let precision = precision {
            currencyFormatter.minimumFractionDigits = precision
            currencyFormatter.maximumFractionDigits = precision
        }

        return currencyFormatter.string(from: NSNumber(value: price))
    }
}
