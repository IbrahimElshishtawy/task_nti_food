class CurrencyFormatter {
  const CurrencyFormatter._();

  static String format(num value) => '\$${value.toStringAsFixed(2)}';
}
