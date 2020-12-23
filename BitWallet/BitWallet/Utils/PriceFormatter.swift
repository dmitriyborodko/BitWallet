import Foundation

struct PriceFormatter {

    static func format(price priceString: String, precision: Int?) -> String? {
        guard let price = Double(priceString) else { return nil }

        let precision = precision ?? 2

        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        currencyFormatter.currencySymbol = "€"
        currencyFormatter.minimumFractionDigits = precision
        currencyFormatter.maximumFractionDigits = precision

        return currencyFormatter.string(from: NSNumber(value: price))
    }
}
