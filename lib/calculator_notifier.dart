import 'package:calculator/math_node.dart';
import 'package:flutter/cupertino.dart';

final class CalculatorNotifierState {
  CalculatorNotifierState({required this.result, required this.expression});

  final double result;
  final String expression;
}

class CalculatorNotifier extends ValueNotifier<CalculatorNotifierState> {
  CalculatorNotifier()
    : super(CalculatorNotifierState(result: 0, expression: ''));

  MathNode? _node;

  void addNumber(String num) {
    _addNode(NumberLeaf(num));
  }

  void add() {
    _addNode(AddOperation());
  }

  void minus() {
    _addNode(MinusOperation());
  }

  void multiply() {
    _addNode(MultiplyOperation());
  }

  void divider() {
    _addNode(DivideOperation());
  }

  void _addNode(MathNode newNode) {
    if (_node == null) {
      _node = newNode;
    } else {
      _node = _node!.chainToTree(newNode);
    }
    if (!_node!.isReady) return;

    value = CalculatorNotifierState(
      result: _node!.calculate(),
      expression: _node!.getExpression(),
    );
  }
}
