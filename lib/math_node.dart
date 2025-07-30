abstract class MathNode {
  bool get isReady;
  String getExpression();
  double calculate();
  int get depth;
  MathNode chainToTree(MathNode newNode);
}

abstract class TwoNodeMathOperation implements MathNode {
  MathNode? node1;
  MathNode? node2;

  TwoNodeMathOperation();

  @override
  MathNode chainToTree(MathNode newNode) {
    if (depth <= newNode.depth) {
      return newNode.chainToTree(this);
    }

    if (node1 == null) {
      node1 = newNode;
      return this;
    }
    if (!node1!.isReady) {
      node1!.chainToTree(newNode);
      return this;
    }

    if (node2 == null) {
      node2 = newNode;
      return this;
    }
    if (!node2!.isReady) {
      node2!.chainToTree(newNode);
      return this;
    }

    throw Exception('failed to chain to tree');
  }

  @override
  bool get isReady =>
      node1 != null && node2 != null && node1!.isReady && node2!.isReady;
}

class NumberLeaf implements MathNode {
  String numberString = '';

  NumberLeaf(this.numberString);

  @override
  String getExpression() {
    return numberString;
  }

  @override
  double calculate() {
    try {
      return double.parse(numberString);
    } catch (e) {
      throw Exception('Invalid Number');
    }
  }

  @override
  MathNode chainToTree(MathNode newNode) {
    if (newNode is NumberLeaf) {
      numberString += newNode.numberString;
      return this;
    }

    return newNode.chainToTree(this);
  }

  @override
  int get depth => -1;

  @override
  bool get isReady => true;
}

class AddOperation extends TwoNodeMathOperation {
  @override
  String getExpression() {
    return '${node1!.getExpression()}+${node2!.getExpression()}';
  }

  @override
  double calculate() {
    return node1!.calculate() + node2!.calculate();
  }

  @override
  int get depth => 1;
}

class MinusOperation extends TwoNodeMathOperation {
  @override
  String getExpression() {
    return '${node1!.getExpression()}-${node2!.getExpression()}';
  }

  @override
  double calculate() {
    return node1!.calculate() - node2!.calculate();
  }

  @override
  int get depth => 1;
}

class DivideOperation extends TwoNodeMathOperation {
  @override
  String getExpression() {
    return '${node1!.getExpression()}/${node2!.getExpression()}';
  }

  @override
  double calculate() {
    return node1!.calculate() / node2!.calculate();
  }

  @override
  int get depth => 2;
}

class MultiplyOperation extends TwoNodeMathOperation {
  @override
  String getExpression() {
    return '${node1!.getExpression()}*${node2!.getExpression()}';
  }

  @override
  double calculate() {
    return node1!.calculate() * node2!.calculate();
  }

  @override
  int get depth => 2;
}
