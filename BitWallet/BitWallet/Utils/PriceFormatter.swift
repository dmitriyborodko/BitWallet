import Foundation

struct PriceFormatter {

    private static let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "€"
        return currencyFormatter
    }()

    static func format(price priceString: String, precision: Int?) -> String? {
        guard let price = Double(priceString) else { return nil }

        let precision = precision ?? 2

        currencyFormatter.locale = Locale.current
        currencyFormatter.minimumFractionDigits = precision
        currencyFormatter.maximumFractionDigits = precision

        return currencyFormatter.string(from: NSNumber(value: price))
    }
}
