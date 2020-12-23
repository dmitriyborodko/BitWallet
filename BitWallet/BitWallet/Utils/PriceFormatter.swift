import Foundation

struct PriceFormatter {

    private static let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    }()

    static func format(price priceString: String, precision: Int?, currencySymbol: String? = "€") -> String? {
        return format(price: Double(priceString), precision: precision, currencySymbol: currencySymbol)
    }

    static func format(price: Double?, precision: Int?, currencySymbol: String? = "€") -> String? {
        currencyFormatter.locale = Locale.current
        currencyFormatter.currencySymbol = currencySymbol

        currencyFormatter.minimumFractionDigits = precision ?? 0
        currencyFormatter.maximumFractionDigits = precision ?? Int.max

        return price.flatMap { currencyFormatter.string(from: NSNumber(value: $0)) }
    }

    static func comparePrices(left: Double?, right: Double?) -> Bool {
        guard let left = left else { return false }
        guard let right = right else { return true }

        return left > right
    }
}
