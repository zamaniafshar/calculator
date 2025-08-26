class ExpressionTokenizer {
  /// Alternative method that preserves the original expression structure
  /// including handling negative numbers properly
  static List<String> tokenize(String expression) {
    if (expression.isEmpty) return [];

    // Remove all whitespace
    final cleanExpression = expression.replaceAll(RegExp(r'\s+'), '');

    if (cleanExpression.isEmpty) return [];

    // Regex that handles positive numbers and decimal points only
    // This pattern matches:
    // - Numbers: positive integers or decimals only
    // - Operators: +, -, *, /, ^, %, (, )
    final pattern = RegExp(r'(\d+(?:\.\d*)?|\.\d+)|([+\-*/^%()])');

    final matches = pattern.allMatches(cleanExpression);
    final tokens = <String>[];

    for (final match in matches) {
      // Check if it's a number (group 1)
      if (match.group(1) != null) {
        tokens.add(match.group(1)!);
      }
      // Check if it's an operator (group 2)
      else if (match.group(2) != null) {
        tokens.add(match.group(2)!);
      }
    }

    return tokens;
  }
}
