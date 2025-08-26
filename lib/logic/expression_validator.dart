class ExpressionValidator {
  bool _isOperator(String symbol) {
    return ['+', '-', '*', '/', '^', '%'].contains(symbol);
  }

  bool _isDigit(String symbol) {
    if (symbol.length != 1) return false;
    int code = symbol.codeUnitAt(0);
    return code >= '0'.codeUnitAt(0) && code <= '9'.codeUnitAt(0);
  }

  bool _isDot(String symbol) {
    return symbol == '.';
  }

  String getUpdatedExpression(String current, String symbol) {
    if (symbol.length != 1) {
      return current; // Disallow multi-character symbols
    }

    if (!_isDigit(symbol) && !_isOperator(symbol) && !_isDot(symbol)) {
      return current; // Disallow unknown symbols
    }

    if (current.isEmpty) {
      if (_isDigit(symbol) || symbol == '-' || symbol == '.') {
        return symbol;
      }
      return current; // Disallow starting with + * /
    }

    String last = current.substring(current.length - 1);

    if (_isOperator(symbol)) {
      if (_isOperator(last)) {
        // Replace last operator with new one
        return current.substring(0, current.length - 1) + symbol;
      } else if (last == '.') {
        // Allow operator after '.', treating '8.' as 8
        return current + symbol;
      } else {
        // After digit, allow operator
        return current + symbol;
      }
    } else if (_isDot(symbol)) {
      // Find the last token (current number after last operator)
      String lastToken = '';
      int i = current.length - 1;
      while (i >= 0 && !_isOperator(current.substring(i, i + 1))) {
        lastToken = current.substring(i, i + 1) + lastToken;
        i--;
      }
      if (lastToken.contains('.')) {
        return current; // Already has dot in current number, disallow
      }
      // Allow dot after operator (implies 0.) or after digits
      return current + symbol;
    } else if (_isDigit(symbol)) {
      // Always allow digits
      return current + symbol;
    }

    return current; // Fallback, though should not reach here
  }
}
