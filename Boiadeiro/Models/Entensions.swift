extension String {
    var toDouble: Double? {
        let replaced = self.replacingOccurrences(of: ",", with: ".")
        return Double(replaced)
    }
}
